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
            color: AppColor.primaryColor,
            backgroundColor: Colors.white,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                /// Modern App Bar
                SliverAppBar(
                  expandedHeight: 120,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                    title: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142), letterSpacing: 0.3),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColor.primaryColor.withOpacity(0.12), AppColor.primaryColor.withOpacity(0.06)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor.withOpacity(0.2), width: 1.5),
                            ),
                            child: Text(
                              '${controller.categoreis.length}',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColor.primaryColor, letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Content
                SliverToBoxAdapter(
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: _buildCategoriesSection(controller)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoute.categoryadd);
        },
        backgroundColor: AppColor.primaryColor,
        icon: Padding(padding: const EdgeInsets.only(right: 8.0), child: SvgPicture.asset(AppSvg.widgetAddSvgrepoCom, color: Colors.white)),
        label: const Text("Add Category", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildCategoriesSection(CategoryController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        if (controller.categoreis.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), spreadRadius: 0, blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.grey.shade100, Colors.grey.shade50]),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(Icons.category_outlined, size: 64, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 24),
                const Text('No Categories Yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                const SizedBox(height: 12),
                Text(
                  'Start by adding your first category\nto organize your products',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
                ),
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
                  _showModernDeleteDialog(context, controller, index);
                },
                categoriesModel: controller.categoreis[index],
              );
            },
          ),
      ],
    );
  }

  void _showModernDeleteDialog(BuildContext context, CategoryController controller, int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.65),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.15), blurRadius: 40, offset: const Offset(0, 20))],
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFDC2626)]),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: const Color(0xFFEF4444).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
                      ),
                      child: const Icon(Icons.delete_rounded, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 24),

                    /// Title
                    const Text('Delete Category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
                    const SizedBox(height: 12),

                    /// Message
                    Text(
                      'Are you sure you want to delete this category? This action cannot be undone.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    /// Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => Get.back(),
                                child: const Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFDC2626)]),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFFEF4444).withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6)),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () async {
                                  Get.back();
                                  await controller.deleteCategories(controller.categoreis[index]);
                                },
                                child: const Center(
                                  child: Text('Delete', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
