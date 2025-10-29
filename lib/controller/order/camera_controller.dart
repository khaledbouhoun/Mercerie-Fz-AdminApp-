import 'package:admin_ecommerce_app/controller/item/item_add_controller.dart';
import 'package:admin_ecommerce_app/controller/item/item_update_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class CameraColorController extends GetxController {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;

  // Observable variables
  final RxBool isCameraInitialized = false.obs;
  final RxBool isProcessing = false.obs;
  final Rx<Color?> pickedColor = Rx<Color?>(null);
  final Rx<Color?> colorsuccess = Rx<Color?>(Colors.white);
  final RxBool isFlashOn = false.obs;
  final RxBool showColorInfo = false.obs;
  final RxBool isAnimating = false.obs;
  final RxDouble borderWidth = 4.0.obs;
  final RxDouble pulseScale = 1.0.obs;
  final RxBool hasPermission = false.obs;

  int page = 1; // 1 for ItemAddController, 2 for ItemUpdateController

  @override
  void onInit() {
    super.onInit();
    page = Get.arguments['page'];
    _checkPermissionsAndInitialize();
  }

  @override
  void onClose() {
    _disposeCamera();
    super.onClose();
  }

  Future<void> _checkPermissionsAndInitialize() async {
    try {
      // Check camera permission
      var status = await Permission.camera.status;
      if (status.isDenied) {
        status = await Permission.camera.request();
      }

      if (status.isGranted) {
        hasPermission.value = true;
        await initializeCameras();
      } else {
        hasPermission.value = false;
        Get.snackbar(
          'Permission Required',
          'Camera permission is required to use this feature',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error checking permissions: $e');
      hasPermission.value = false;
    }
  }

  Future<void> _disposeCamera() async {
    try {
      if (cameraController != null) {
        await cameraController!.dispose();
        cameraController = null;
      }
    } catch (e) {
      print('Error disposing camera: $e');
    }
  }

  Future<void> initializeCameras() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        await initializeCamera();
      } else {
        Get.snackbar(
          'No Camera',
          'No cameras found on this device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on CameraException catch (e) {
      print('Camera Error: ${e.code}\nError Message: ${e.description}');
      Get.snackbar(
        'Camera Error',
        'Failed to access camera: ${e.description}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error initializing cameras: $e');
      Get.snackbar(
        'Error',
        'Failed to initialize camera',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> initializeCamera() async {
    if (cameras.isEmpty) return;

    try {
      // Dispose previous controller if exists
      await _disposeCamera();

      // Always use the back camera (first camera in the list)
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium, // Use medium resolution for better performance
      );

      initializeControllerFuture = cameraController?.initialize();

      await initializeControllerFuture;
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
      isCameraInitialized.value = false;
      Get.snackbar(
        'Camera Error',
        'Failed to initialize camera',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> toggleFlash() async {
    if (cameraController == null || !isCameraInitialized.value) return;

    try {
      if (isFlashOn.value) {
        await cameraController!.setFlashMode(FlashMode.off);
        isFlashOn.value = false;
      } else {
        await cameraController!.setFlashMode(FlashMode.torch);
        isFlashOn.value = true;
      }
    } catch (e) {
      print('Error toggling flash: $e');
    }
  }

  Color extractCenterColor(img.Image image) {
    final int centerX = image.width ~/ 2;
    final int centerY = image.height ~/ 2;
    final int sampleSize = 20;
    final int halfSample = sampleSize ~/ 2;

    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;
    int pixelCount = 0;

    for (int y = centerY - halfSample; y <= centerY + halfSample; y++) {
      for (int x = centerX - halfSample; x <= centerX + halfSample; x++) {
        if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
          final img.Pixel pixel = image.getPixel(x, y);
          totalRed += pixel.r.toInt();
          totalGreen += pixel.g.toInt();
          totalBlue += pixel.b.toInt();
          pixelCount++;
        }
      }
    }

    if (pixelCount == 0) return Colors.black;

    final int avgRed = totalRed ~/ pixelCount;
    final int avgGreen = totalGreen ~/ pixelCount;
    final int avgBlue = totalBlue ~/ pixelCount;

    return Color.fromARGB(255, avgRed, avgGreen, avgBlue);
  }

  Future<void> takePictureAndExtractColor() async {
    if (cameraController == null || !isCameraInitialized.value) {
      Get.snackbar(
        'Error',
        'Camera not initialized',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      animateError();
      return;
    }

    isProcessing.value = true;
    animateButtonPress();
    animateProcessing();

    try {
      await initializeControllerFuture;

      final XFile imageFile = await cameraController!.takePicture();
      final File file = File(imageFile.path);
      final Uint8List bytes = await file.readAsBytes();

      final img.Image? capturedImage = img.decodeImage(bytes);

      if (capturedImage != null) {
        final Color centerColor = extractCenterColor(capturedImage);
        pickedColor.value = centerColor;
        showColorInfo.value = true;

        animateColorSelected();
      } else {
        Get.snackbar(
          'Error',
          'Failed to process image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        animateError();
      }
    } catch (e) {
      print('Error taking picture or extracting color: $e');
      Get.snackbar(
        'Error',
        'Failed to extract color: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      animateError();
    } finally {
      isProcessing.value = false;
    }
  }

  void confirmColor() {
    if (pickedColor.value != null) {
      animateFlash();
      if (page == 1) {
        Get.find<ItemAddController>().addcolor(pickedColor.value!);
      } else if (page == 2) {
        Get.find<ItemUpdateController>().addcolor(pickedColor.value!);
      }
      resetColor();
    } else {
      animateError();
      Get.snackbar('Error', 'No color selected', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void resetColor() {
    pickedColor.value = null;
    showColorInfo.value = false;
    colorsuccess.value = Colors.white;
    stopAnimations();
  }

  void animateSuccess() {
    isAnimating.value = true;
    colorsuccess.value = Colors.green;

    // Fast double pulse animation
    Future.delayed(Duration(milliseconds: 50), () {
      borderWidth.value = 8.0;
      pulseScale.value = 1.15;
    });

    Future.delayed(Duration(milliseconds: 150), () {
      borderWidth.value = 4.0;
      pulseScale.value = 1.0;
    });

    Future.delayed(Duration(milliseconds: 250), () {
      borderWidth.value = 8.0;
      pulseScale.value = 1.15;
    });

    Future.delayed(Duration(milliseconds: 350), () {
      borderWidth.value = 4.0;
      pulseScale.value = 1.0;
      isAnimating.value = false;
    });
  }

  void animateError() {
    isAnimating.value = true;
    colorsuccess.value = Colors.red;

    // Fast shake animation
    for (int i = 0; i < 8; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        if (i % 2 == 0) {
          borderWidth.value = 6.0;
          pulseScale.value = 0.9;
        } else {
          borderWidth.value = 4.0;
          pulseScale.value = 1.1;
        }
      });
    }

    Future.delayed(Duration(milliseconds: 400), () {
      borderWidth.value = 4.0;
      pulseScale.value = 1.0;
      isAnimating.value = false;
    });
  }

  void animateProcessing() {
    isAnimating.value = true;
    colorsuccess.value = Colors.blue;

    // Fast continuous pulse animation
    _startFastPulseAnimation();
  }

  void _startFastPulseAnimation() {
    if (!isProcessing.value) {
      isAnimating.value = false;
      return;
    }

    borderWidth.value = 6.0;
    pulseScale.value = 1.08;

    Future.delayed(Duration(milliseconds: 200), () {
      if (isProcessing.value) {
        borderWidth.value = 4.0;
        pulseScale.value = 1.0;
        Future.delayed(Duration(milliseconds: 200), () {
          if (isProcessing.value) {
            _startFastPulseAnimation();
          }
        });
      }
    });
  }

  // New fast bounce animation for color selection
  void animateColorSelected() {
    isAnimating.value = true;
    colorsuccess.value = Colors.purple;

    // Bounce effect
    Future.delayed(Duration(milliseconds: 30), () {
      pulseScale.value = 1.2;
      borderWidth.value = 10.0;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      pulseScale.value = 0.9;
      borderWidth.value = 6.0;
    });

    Future.delayed(Duration(milliseconds: 200), () {
      pulseScale.value = 1.1;
      borderWidth.value = 8.0;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      pulseScale.value = 1.0;
      borderWidth.value = 4.0;
      isAnimating.value = false;
    });
  }

  // New rapid flash animation
  void animateFlash() {
    isAnimating.value = true;
    colorsuccess.value = Colors.yellow;

    // Quick flash effect
    for (int i = 0; i < 6; i++) {
      Future.delayed(Duration(milliseconds: i * 80), () {
        if (i % 2 == 0) {
          borderWidth.value = 12.0;
          pulseScale.value = 1.25;
        } else {
          borderWidth.value = 4.0;
          pulseScale.value = 1.0;
        }
      });
    }

    Future.delayed(Duration(milliseconds: 480), () {
      borderWidth.value = 4.0;
      pulseScale.value = 1.0;
      isAnimating.value = false;
    });
  }

  // Quick press animation for camera button
  void animateButtonPress() {
    isAnimating.value = true;
    colorsuccess.value = Colors.orange;

    // Quick press effect
    Future.delayed(Duration(milliseconds: 20), () {
      pulseScale.value = 0.95;
      borderWidth.value = 6.0;
    });

    Future.delayed(Duration(milliseconds: 100), () {
      pulseScale.value = 1.0;
      borderWidth.value = 4.0;
      isAnimating.value = false;
    });
  }

  void stopAnimations() {
    isAnimating.value = false;
    borderWidth.value = 4.0;
    pulseScale.value = 1.0;
  }

  String getColorName(Color color) {
    // Simple color naming logic
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    if (red > 200 && green > 200 && blue > 200) return 'White';
    if (red < 50 && green < 50 && blue < 50) return 'Black';
    if (red > 200 && green < 100 && blue < 100) return 'Red';
    if (red < 100 && green > 200 && blue < 100) return 'Green';
    if (red < 100 && green < 100 && blue > 200) return 'Blue';
    if (red > 200 && green > 200 && blue < 100) return 'Yellow';
    if (red > 200 && green < 100 && blue > 200) return 'Magenta';
    if (red < 100 && green > 200 && blue > 200) return 'Cyan';
    if (red > 200 && green < 200 && green > 100 && blue < 100) return 'Orange';
    if (red > 150 && green < 100 && blue > 150) return 'Purple';

    return 'Custom';
  }
}
