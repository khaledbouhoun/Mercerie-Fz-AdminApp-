import 'package:admin_ecommerce_app/controller/category/category_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/widget/categorywidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () async => controller.getCategories(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: _buildCategoriesSection(controller),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoute.categoryadd);
        },
        backgroundColor: AppColor.primaryColor,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AppSvg.addFolderSvgrepoCom, color: Colors.white, width: 24, height: 24),
        ),
        label: const Text("Add Category", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildHeaderSection(CategoryController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text(
                    '${controller.categoreis.length} categories available',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.category, color: AppColor.primaryColor, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Categories', controller.categoreis.length.toString(), Icons.category, Colors.purple)),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Active Categories', controller.categoreis.length.toString(), Icons.check_circle, Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
              Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(CategoryController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('All Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(
                '${controller.categoreis.length} categories',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (controller.categoreis.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.category_outlined, size: 60, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 16),
                const Text('No Categories Found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text('Add your first category to get started', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              ],
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categoreis.length,
            itemBuilder: (context, index) {
              return Categorywidget(
                onedit: () {
                  controller.editCategoriesName.text = controller.categoreis[index].categoriesName!;
                  controller.editCategoriesNameArabic.text = controller.categoreis[index].categoriesNamaAr!;
                  controller.editpath = controller.categoreis[index].categoriesImage!;
                  Get.toNamed(AppRoute.categoryupdate, arguments: {"categoriesModel": controller.categoreis[index]});
                },
                ondelete: () {
                  Get.defaultDialog(
                    title: 'Delete Category',
                    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    titlePadding: const EdgeInsets.only(top: 24),
                    contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    radius: 16,
                    content: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Icon(Icons.delete_forever, color: Colors.red.shade600, size: 32),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Are you sure you want to delete this category? This action cannot be undone.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    confirm: ElevatedButton(
                      onPressed: () async {
                        Get.back();
                        await controller.deleteCategories(controller.categoreis[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(120, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Delete'),
                    ),
                    cancel: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        minimumSize: const Size(120, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  );
                },
                categoriesModel: controller.categoreis[index],
              );
            },
          ),
      ],
    );
  }
}
