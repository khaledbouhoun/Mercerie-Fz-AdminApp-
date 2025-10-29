import 'dart:io';
import 'package:admin_ecommerce_app/controller/item/item_add_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/data/model/unite_model.dart';
import 'package:admin_ecommerce_app/view/order/camera.dart';
import 'package:admin_ecommerce_app/widget/backwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Itemadd extends StatelessWidget {
  const Itemadd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: _buildAppBar(context),
      body: GetBuilder<ItemAddController>(
        init: ItemAddController(),
        builder: (controller) {
          return _buildBody(controller, context);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.background,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.add_shopping_cart, color: AppColor.primaryColor, size: 24),
          ),
          const SizedBox(width: 12),
          const Text('Add Product', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
      leading: Backwidget(),
      centerTitle: false,
    );
  }

  Widget _buildBody(ItemAddController controller, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formstate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(
                    "Basic Information",
                    SvgPicture.asset(AppSvg.info, color: AppColor.primaryColor, width: 24, height: 24),
                  ),
                  Row(
                    children: [
                      _buildImagePickerButton(
                        icon: SvgPicture.asset(AppSvg.cameraAddSvgrepoCom, color: AppColor.primaryColor, width: 25, height: 25),
                        onTap: () async {
                          File? image = await controller.pickImageFromCamera();
                          if (image != null) {
                            controller.images.add(image);
                          }
                          controller.update();
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildImagePickerButton(
                        icon: SvgPicture.asset(AppSvg.galleryAddSvgrepoCom, color: AppColor.primaryColor, width: 25, height: 25),
                        onTap: () async {
                          // Allow picking multiple images from gallery
                          final List<XFile> pickedFiles = await controller.picker.pickMultiImage();
                          if (pickedFiles.isNotEmpty) {
                            controller.images.addAll(pickedFiles.map((xfile) => File(xfile.path)));
                            controller.update();
                          } else {
                            // fallback to single image picker if pickMultiImage not supported
                            File? image = await controller.pickImageFromGallery();
                            if (image != null) {
                              controller.images.add(image);
                              controller.update();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildImagePickerSection(controller),
              const SizedBox(height: 24),
              _buildInputField(
                context,
                controller: controller.itemName,
                label: "Product Name",
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(AppSvg.widget2SvgrepoCom1, color: AppColor.primaryColor, width: 20, height: 20),
                ),
                validator: (value) => value!.isEmpty ? "Please enter Product name" : null,
              ),
              _buildInputField(
                context,
                controller: controller.itemNameArabic,
                label: "Product Name (Arabic)",
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(AppSvg.language, color: AppColor.primaryColor, width: 20, height: 20),
                ),
                validator: (value) => value!.isEmpty ? "Please enter Arabic name" : null,
              ),
              _buildInputField(
                context,
                controller: controller.itemDescription,
                label: "Description",
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(AppSvg.document, color: AppColor.primaryColor, width: 20, height: 20),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? "Please enter description" : null,
              ),
              _buildInputField(
                context,
                controller: controller.itemDescriptionArabic,
                label: "Description (Arabic)",
                icon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(AppSvg.document, color: AppColor.primaryColor, width: 20, height: 20),
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? "Please enter description" : null,
              ),

              const SizedBox(height: 20),
              _buildSectionTitle(
                "Category",
                SvgPicture.asset(AppSvg.folderWithFilesSvgrepoCom, color: AppColor.primaryColor, width: 24, height: 24),
              ),
              const SizedBox(height: 20),
              _buildCategoryDropdown(controller),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Visibility(
                    visible: controller.categoryselctederoor.value,
                    child: Text("Please select a category", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 174, 0, 0))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle(
                "Pricing & Size",
                SvgPicture.asset(AppSvg.folderWithFilesSvgrepoCom, color: AppColor.primaryColor, width: 24, height: 24),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      context,
                      controller: controller.itemPrice,
                      label: "Price",
                      icon: Icon(Icons.attach_money, color: AppColor.primaryColor, size: 30),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? "Enter price" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInputField(
                      context,
                      controller: controller.itemLimite,
                      label: "Limite",
                      keyboardType: TextInputType.number,

                      icon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(AppSvg.subtractCircleMinusRemoveSvgrepoCom, color: AppColor.primaryColor),
                      ),
                      validator: (value) => value!.isEmpty ? "Enter limite" : null,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildInputField(
                      context,
                      controller: controller.itemSize,
                      label: "Size",

                      icon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(AppSvg.rulerAngularSvgrepoCom, color: AppColor.primaryColor, width: 20, height: 20),
                      ),
                      validator: (value) => value!.isEmpty ? "Enter size" : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: _buildUniteDropdown(controller)),
                ],
              ),
              const SizedBox(height: 20),

              _buildSectionTitle(
                "Product Colors",
                SvgPicture.asset(AppSvg.paletteSvgrepoCom, color: AppColor.primaryColor, width: 24, height: 24),
              ),
              const SizedBox(height: 20),
              _buildColorSectionTitle(controller),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Visibility(
                    visible: controller.colorselctederoor.value,
                    child: Text("Please select a colors", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 174, 0, 0))),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              _buildSubmitButton(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerSection(ItemAddController controller) {
    return Center(
      child: Container(
        width: Get.width,
        height: Get.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.primaryColor.withOpacity(0.3)),
        ),
        child:
            controller.images.isNotEmpty
                ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(controller.images[index], width: 150, height: 250, fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: GestureDetector(
                            onTap: () {
                              controller.images.removeAt(index);
                              controller.update();
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                              child: const Icon(Icons.close, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
                : Padding(
                  padding: const EdgeInsets.all(80),
                  child: SvgPicture.asset(AppSvg.gallerysvgrepocom, color: AppColor.primaryColor),
                ),
      ),
    );
  }

  Widget _buildCategoryDropdown(ItemAddController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CategoriesModel>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
          hint: const Text("Select Category"),
          value: controller.selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: AppColor.primaryColor),
          items:
              controller.categories.map((category) {
                return DropdownMenuItem<CategoriesModel>(value: category, child: Text(category.categoriesName!));
              }).toList(),
          onChanged: (newValue) {
            controller.selectedCategory = newValue;
            controller.categoryselctederoor.value = false; // Reset error when a category is selected
            controller.update();
          },
        ),
      ),
    );
  }

  Widget _buildUniteDropdown(ItemAddController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UniteModel>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
          hint: const Text("Unite"),
          value: controller.selectedUnite,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: AppColor.primaryColor),
          items:
              controller.unites.map((unite) {
                return DropdownMenuItem<UniteModel>(value: unite, child: Text(unite.uniteNameFr!));
              }).toList(),
          onChanged: (newValue) {
            controller.selectedUnite = newValue;
            controller.update();
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ItemAddController controller) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
        ),
        onPressed: () async {
          await controller.additemes();
        },
        child: Obx(
          () =>
              controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text("Add Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Widget icon) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildColorSectionTitle(ItemAddController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, spreadRadius: 0)],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: controller.listColor.length + 2,
        itemBuilder: (context, index) {
          if (index < controller.listColor.length) {
            return InkWell(
              onLongPress: () {
                controller.listColor.removeAt(index);
                controller.update();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.listColor[index],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: controller.listColor[index].withOpacity(0.3), blurRadius: 20, spreadRadius: 5),

                    BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, spreadRadius: 1),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Icon(
                        Icons.check_circle,
                        size: 16,
                        color: controller.listColor[index].computeLuminance() > 0.5 ? Colors.black54 : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                if (index == controller.listColor.length + 1) {
                  Get.to(() => CameraColorPickerScreen(), arguments: {'page': 1}); // Pass page argument for ItemAddController
                } else {
                  // Show color picker dialog
                  Get.defaultDialog(
                    title: 'Choose Color',
                    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    backgroundColor: Colors.white,
                    radius: 20,
                    content: Column(
                      children: [
                        SizedBox(
                          height: 500,
                          child: MaterialPicker(
                            pickerColor: Colors.blue,
                            onColorChanged: (Color color) {
                              if (!controller.listColor.contains(color)) {
                                controller.addcolor(color);
                                controller.colorselctederoor.value = false;
                                controller.update();
                                Get.back();
                              }
                            },
                            enableLabel: false,
                            portraitOnly: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => Get.back(),
                            child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    barrierDismissible: true,
                  );
                }
              },
              child: Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColor.primaryColor.withOpacity(0.5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      index == controller.listColor.length + 1
                          ? SvgPicture.asset(AppSvg.cameraAddSvgrepoCom, color: AppColor.primaryColor, width: 15, height: 15)
                          : SvgPicture.asset(AppSvg.paletteSvgrepoCom, color: AppColor.primaryColor, width: 15, height: 15),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required Widget icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColor.primaryColor),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImagePickerButton({required Widget icon, required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: InkWell(onTap: onTap, child: icon),
    );
  }
}
