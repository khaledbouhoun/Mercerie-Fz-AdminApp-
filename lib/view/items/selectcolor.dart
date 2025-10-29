import 'dart:typed_data';
import 'package:admin_ecommerce_app/controller/item/item_add_controller.dart';
import 'package:admin_ecommerce_app/controller/item/item_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';

class Selectcolor extends StatelessWidget {
  const Selectcolor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.8,

          child: SingleChildScrollView(
            child: GetBuilder<ItemAddController>(
              init: ItemAddController(),

              builder: (controller) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Selecte Image", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                        IconButton(
                          onPressed: () async {
                            controller.image2 = await controller.pickImageFromCamera();
                            controller.update();
                          },
                          icon: const Icon(Icons.camera_alt_rounded, color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () async {
                            controller.image2 = await controller.pickImageFromGallery();
                            controller.update();
                          },
                          icon: const Icon(Icons.photo, color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () async {
                            controller.vis1 = !controller.vis1;
                            controller.update();
                          },
                          icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                        ),
                      ],
                    ),

                    Visibility(
                      visible: controller.vis1,
                      child:
                          controller.image2 != null
                              ? FutureBuilder(
                                future: controller.image2!.readAsBytes(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return const SizedBox();
                                  final bytes = snapshot.data as Uint8List;
                                  final decodedImage = img.decodeImage(bytes);
                                  if (decodedImage == null) return const SizedBox();

                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      final displayWidth = constraints.maxWidth;
                                      final displayHeight = displayWidth * decodedImage.height / decodedImage.width;

                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTapDown: (details) async {
                                              final RenderBox box = context.findRenderObject() as RenderBox;
                                              final localPosition = box.globalToLocal(details.globalPosition);

                                              // Calculate tap position in image coordinates
                                              double scaleX = decodedImage.width / displayWidth;
                                              double scaleY = decodedImage.height / displayHeight;
                                              int x = (localPosition.dx * scaleX).toInt();
                                              int y = (localPosition.dy * scaleY).toInt();

                                              // Get pixel color
                                              var pixel = decodedImage.getPixel(x, y);
                                              int colorValue =
                                                  (pixel.a.toInt() << 24) |
                                                  (pixel.r.toInt() << 16) |
                                                  (pixel.g.toInt() << 8) |
                                                  (pixel.b.toInt());
                                              controller.color = Color(colorValue);

                                              // Save tap position in display coordinates
                                              controller.tapPosition = Offset(localPosition.dx, localPosition.dy);
                                              controller.update();
                                            },
                                            child: Image.file(
                                              controller.image2!,
                                              width: displayWidth,
                                              height: displayHeight,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          if (controller.tapPosition != null)
                                            Positioned(
                                              left: controller.tapPosition!.dx - 30,
                                              top: controller.tapPosition!.dy - 30,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: controller.color.withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Colors.white, width: 4),
                                                  boxShadow: [
                                                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
                                                  ],
                                                ),
                                                child: Icon(Icons.add, color: Colors.white, size: 20),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                              : const Text("No image selected"),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Selcet Color", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                        IconButton(
                          onPressed: () async {
                            controller.vis2 = !controller.vis2;
                            controller.update();
                          },
                          icon: const Icon(Icons.photo, color: Colors.blue),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: controller.vis2,
                      child: ColorPicker(
                        pickerColor: controller.color,
                        onColorChanged: (colornew) {
                          controller.color = colornew;
                          controller.update();
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.listColor.add(controller.color);
                        controller.update();
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: controller.color),
                        alignment: Alignment.center,
                        child: Text("Add Color", style: TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


class SelectcolorUpdtae extends StatelessWidget {
  const SelectcolorUpdtae({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.8,

          child: SingleChildScrollView(
            child: GetBuilder<ItemUpdateController>(
              init: ItemUpdateController(),

              builder: (controller) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Selecte Image", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                        IconButton(
                          onPressed: () async {
                            controller.image2 = await controller.pickImageFromCamera();
                            controller.update();
                          },
                          icon: const Icon(Icons.camera_alt_rounded, color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () async {
                            controller.image2 = await controller.pickImageFromGallery();
                            controller.update();
                          },
                          icon: const Icon(Icons.photo, color: Colors.blue),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () async {
                            controller.vis1 = !controller.vis1;
                            controller.update();
                          },
                          icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                        ),
                      ],
                    ),

                    Visibility(
                      visible: controller.vis1,
                      child:
                          controller.image2 != null
                              ? FutureBuilder(
                                future: controller.image2!.readAsBytes(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return const SizedBox();
                                  final bytes = snapshot.data as Uint8List;
                                  final decodedImage = img.decodeImage(bytes);
                                  if (decodedImage == null) return const SizedBox();

                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      final displayWidth = constraints.maxWidth;
                                      final displayHeight = displayWidth * decodedImage.height / decodedImage.width;

                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTapDown: (details) async {
                                              final RenderBox box = context.findRenderObject() as RenderBox;
                                              final localPosition = box.globalToLocal(details.globalPosition);

                                              // Calculate tap position in image coordinates
                                              double scaleX = decodedImage.width / displayWidth;
                                              double scaleY = decodedImage.height / displayHeight;
                                              int x = (localPosition.dx * scaleX).toInt();
                                              int y = (localPosition.dy * scaleY).toInt();

                                              // Get pixel color
                                              var pixel = decodedImage.getPixel(x, y);
                                              int colorValue =
                                                  (pixel.a.toInt() << 24) |
                                                  (pixel.r.toInt() << 16) |
                                                  (pixel.g.toInt() << 8) |
                                                  (pixel.b.toInt());
                                              controller.color = Color(colorValue);

                                              // Save tap position in display coordinates
                                              controller.tapPosition = Offset(localPosition.dx, localPosition.dy);
                                              controller.update();
                                            },
                                            child: Image.file(
                                              controller.image2!,
                                              width: displayWidth,
                                              height: displayHeight,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          if (controller.tapPosition != null)
                                            Positioned(
                                              left: controller.tapPosition!.dx - 30,
                                              top: controller.tapPosition!.dy - 30,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: controller.color.withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Colors.white, width: 4),
                                                  boxShadow: [
                                                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2),
                                                  ],
                                                ),
                                                child: Icon(Icons.add, color: Colors.white, size: 20),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              )
                              : const Text("No image selected"),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Selcet Color", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                        IconButton(
                          onPressed: () async {
                            controller.vis2 = !controller.vis2;
                            controller.update();
                          },
                          icon: const Icon(Icons.photo, color: Colors.blue),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: controller.vis2,
                      child: ColorPicker(
                        pickerColor: controller.color,
                        onColorChanged: (colornew) {
                          controller.color = colornew;
                          controller.update();
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.listColor.add(controller.color);
                        controller.update();
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: controller.color),
                        alignment: Alignment.center,
                        child: Text("Add Color", style: TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

