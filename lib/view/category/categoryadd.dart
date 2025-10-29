import 'package:admin_ecommerce_app/controller/category/category_add_controller.dart';
import 'package:admin_ecommerce_app/controller/category/category_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/widget/backwidget.dart';
import 'package:admin_ecommerce_app/widget/custombutton.dart';
import 'package:admin_ecommerce_app/widget/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoryAdd extends StatelessWidget {
  const CategoryAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryAddController controller = Get.put(CategoryAddController());
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Add Category'),
        leading: Backwidget(),

        centerTitle: true,
      ),
      body: GetBuilder<CategoryAddController>(
        init: CategoryAddController(),
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: controller.formstate,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextForm(
                      labeltext: "Category Name (French)",
                      iconData: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(AppSvg.folderWithFilesSvgrepoCom, color: AppColor.primaryColor, width: 10, height: 10),
                      ),
                      formstate: controller.formstate,
                      mycontroller: controller.categoriesName,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "Please enter category name";
                        }
                        return null;
                      },
                      isNumber: false,
                    ),
                    CustomTextForm(
                      textInputAction: TextInputAction.done,
                      labeltext: "Category Name (Arabic)",
                      iconData: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(AppSvg.folderWithFilesSvgrepoCom, color: AppColor.primaryColor, width: 10, height: 10),
                      ),
                      formstate: controller.formstate,
                      mycontroller: controller.categoriesNameArabic,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "Please enter category name in Arabic";
                        }
                        return null;
                      },
                      isNumber: false,
                    ),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2)),
                        boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                      ),
                      child: Column(
                        children: [
                          controller.image != null
                              ? Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(image: FileImage(controller.image!), fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.close, color: Colors.red[400]),
                                        onPressed: () {
                                          controller.image = null;
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              : Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColor.primaryColor.withOpacity(0.2), width: 2, style: BorderStyle.solid),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined, size: 50, color: AppColor.primaryColor.withOpacity(0.5)),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Click to add category image",
                                      style: TextStyle(color: AppColor.primaryColor.withOpacity(0.7), fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  controller.image = await controller.pickImageFromCamera();
                                  controller.update();
                                },
                                icon: const Icon(Icons.camera_alt_rounded),
                                label: const Text("Take Photo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  controller.image = await controller.pickImageFromGallery();
                                  controller.update();
                                },
                                icon: const Icon(Icons.photo_library),
                                label: const Text("Choose Image"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[600],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButtom(
                          isLoading: controller.isLoading,
                          text: "Add Category",
                          onPressed: () async {
                            await controller.addCategories();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
