import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_ecommerce_app/controller/order/camera_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';

class CameraColorPickerScreen extends StatelessWidget {
  const CameraColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CameraColorController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.primaryColor.withOpacity(0.1), AppColor.background, AppColor.background],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (!controller.hasPermission.value) {
              return _buildPermissionDeniedScreen();
            }
            if (!controller.isCameraInitialized.value) {
              return _buildLoadingScreen();
            }
            return _buildCameraScreen(controller);
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.primaryColor.withOpacity(0.1), AppColor.background],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(40)),
              child: Icon(Icons.camera_alt, size: 40, color: AppColor.primaryColor),
            ),
            SizedBox(height: 20),
            Text('Initializing Camera...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColor.black)),
            SizedBox(height: 10),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.primaryColor.withOpacity(0.1), AppColor.background],
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(40)),
                child: Icon(Icons.camera_alt, size: 40, color: Colors.red),
              ),
              SizedBox(height: 20),
              Text(
                'Camera Permission Required',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'This app needs camera permission to pick colors. Please grant camera permission in your device settings.',
                style: TextStyle(fontSize: 16, color: AppColor.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Text('Go Back', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraScreen(CameraColorController controller) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera Preview
        Container(
          margin: EdgeInsets.all(16),
          child: ClipRRect(borderRadius: BorderRadius.circular(20), child: CameraPreview(controller.cameraController!)),
        ),

        // Top Controls
        Positioned(top: 20, left: 20, right: 20, child: _buildTopControls(controller)),

        // Center Color Indicator
        Center(child: _buildCenterIndicator(controller)),

        // Bottom Controls
        Positioned(bottom: 20, left: 20, right: 20, child: _buildBottomControls(controller)),

        // Color Info Panel
        if (controller.showColorInfo.value) Positioned(top: 100, left: 20, right: 20, child: _buildColorInfoPanel(controller)),
      ],
    );
  }

  Widget _buildTopControls(CameraColorController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(25)),
          child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, color: Colors.white), iconSize: 24),
        ),

        // Title
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(25)),
          child: Text('Color Picker', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        ),

        // Flash Toggle
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(25)),
          child: IconButton(
            onPressed: controller.toggleFlash,
            icon: Obx(
              () => Icon(
                controller.isFlashOn.value ? Icons.flash_on : Icons.flash_off,
                color: controller.isFlashOn.value ? Colors.yellow : Colors.white,
              ),
            ),
            iconSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterIndicator(CameraColorController controller) {
    return Obx(
      () => Transform.scale(
        scale: controller.pulseScale.value,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: controller.colorsuccess.value ?? Colors.white, width: controller.borderWidth.value),
            color: controller.pickedColor.value ?? Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)],
          ),
          child: controller.pickedColor.value == null ? Icon(Icons.add, size: 40, color: Colors.white) : null,
        ),
      ),
    );
  }

  Widget _buildBottomControls(CameraColorController controller) {
    return Column(
      children: [
        // Main Camera Button
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
          ),
          child: Obx(
            () => FloatingActionButton(
              onPressed: controller.isProcessing.value ? null : controller.takePictureAndExtractColor,
              backgroundColor: AppColor.primaryColor,
              child:
                  controller.isProcessing.value
                      ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                      )
                      : Icon(Icons.camera_alt, size: 30, color: Colors.white),
            ),
          ),
        ),

        SizedBox(height: 20),

        // Action Buttons
        if (controller.pickedColor.value != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(onPressed: controller.resetColor, icon: Icons.refresh, label: 'Reset', color: Colors.orange),
              _buildActionButton(onPressed: controller.confirmColor, icon: Icons.check, label: 'Confirm', color: Colors.green),
            ],
          ),
      ],
    );
  }

  Widget _buildActionButton({required VoidCallback onPressed, required IconData icon, required String label, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorInfoPanel(CameraColorController controller) {
    final color = controller.pickedColor.value;
    if (color == null) return SizedBox.shrink();

    final colorName = controller.getColorName(color);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(colorName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black)),
                    Text('RGB(${color.red}, ${color.green}, ${color.blue})', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildColorValue('R', color.red.toString()),
              _buildColorValue('G', color.green.toString()),
              _buildColorValue('B', color.blue.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorValue(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColor.background, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.grey)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.black)),
        ],
      ),
    );
  }
}
