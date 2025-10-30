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
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Add Category',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.primaryColor, letterSpacing: 0.5),
        ),
        leading: Backwidget(),
        centerTitle: true,
      ),
      body: GetBuilder<CategoryAddController>(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category Image',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Upload a high-quality image for your category',
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                            child:
                                controller.image != null
                                    ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(controller.image!, fit: BoxFit.cover),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: Material(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(30),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(30),
                                              onTap: () {
                                                controller.image = null;
                                                controller.update();
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Icon(Icons.close, color: Colors.red.shade400, size: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                    : Center(
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            children: [
                              Expanded(
                                child: Material(
                                  color: AppColor.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () async {
                                      controller.image = await controller.pickImageFromCamera();
                                      controller.update();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.camera_alt_rounded, color: AppColor.primaryColor, size: 24),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Camera",
                                            style: TextStyle(color: AppColor.primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Material(
                                  color: Colors.green.shade600.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () async {
                                      controller.image = await controller.pickImageFromGallery();
                                      controller.update();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.photo_library, color: Colors.green.shade600, size: 24),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(color: Colors.green.shade600, fontSize: 14, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Fields
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.primaryColor)),
                        const SizedBox(height: 24),
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
                        const SizedBox(height: 16),
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Add Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)]),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: AppColor.primaryColor.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap:
                            controller.isLoading.value
                                ? null
                                : () async {
                                  await controller.addCategories();
                                },
                        child: Center(
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                  : const Text(
                                    "Add Category",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
