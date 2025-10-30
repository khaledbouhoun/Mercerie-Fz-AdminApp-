import 'package:admin_ecommerce_app/controller/item/item_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/widget/itemwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.put(ItemController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: GetBuilder<ItemController>(
        init: ItemController(),
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getitems();
              await controller.getCategories();
              return Future.value();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    // Modern header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
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
                                  const Text('Products', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                                  const SizedBox(height: 6),
                                  Text('${controller.items.length} items', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.inventory_2, color: AppColor.primaryColor, size: 24),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColor.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColor.grey.withOpacity(0.2)),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search products...',
                                      hintStyle: TextStyle(color: AppColor.grey),
                                      prefixIcon: Icon(Icons.search, color: AppColor.grey),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    ),
                                    onChanged: (value) {
                                      controller.searchItems(value);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  icon: const Icon(Icons.filter_list, color: AppColor.white),
                                  onPressed: () {
                                    // ...existing code for filter bottom sheet...
                                    Get.bottomSheet(
                                      GetBuilder<ItemController>(
                                        init: ItemController(),
                                        builder: (context) {
                                          return Container(
                                            height: Get.height * 0.6,
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // ...existing code for filter chips, price, status, reset...
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Filter Products',
                                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                      ),
                                                      IconButton(
                                                        onPressed: () => Get.back(),
                                                        icon: const Icon(Icons.close),
                                                        style: IconButton.styleFrom(
                                                          backgroundColor: Colors.grey.shade100,
                                                          padding: const EdgeInsets.all(8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Categories',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.grey.shade800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Wrap(
                                                    spacing: 8,
                                                    runSpacing: 8,
                                                    children:
                                                        controller.categoreis.map((category) {
                                                          final isSelected = controller.selectedCategory == category.categoriesId;
                                                          return FilterChip(
                                                            label: Text(category.categoriesName!),
                                                            selected: isSelected,
                                                            onSelected: (selected) {
                                                              controller.filterByCategory(selected ? category.categoriesId : null);
                                                              controller.applyFilters();
                                                            },
                                                            backgroundColor: Colors.grey.shade100,
                                                            selectedColor: AppColor.primaryColor.withOpacity(0.2),
                                                            checkmarkColor: AppColor.primaryColor,
                                                            labelStyle: TextStyle(
                                                              color: isSelected ? AppColor.primaryColor : Colors.grey.shade800,
                                                            ),
                                                          );
                                                        }).toList(),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Price Range',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.grey.shade800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextField(
                                                          controller: controller.minPriceController,
                                                          decoration: InputDecoration(
                                                            hintText: 'Min',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                          ),
                                                          keyboardType: TextInputType.number,
                                                          onChanged: (value) {
                                                            controller.applyFilters();
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: TextField(
                                                          controller: controller.maxPriceController,
                                                          decoration: InputDecoration(
                                                            hintText: 'Max',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                          ),
                                                          keyboardType: TextInputType.number,
                                                          onChanged: (value) {
                                                            controller.applyFilters();
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Status',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.grey.shade800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      FilterChip(
                                                        label: const Text('Active'),
                                                        selected: controller.showActiveOnly,
                                                        onSelected: (selected) {
                                                          controller.filterByStatus(selected, false);
                                                          controller.applyFilters();
                                                        },
                                                        backgroundColor: Colors.grey.shade100,
                                                        selectedColor: Colors.green.shade100,
                                                        checkmarkColor: Colors.green,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      FilterChip(
                                                        label: const Text('Inactive'),
                                                        selected: controller.showInactiveOnly,
                                                        onSelected: (selected) {
                                                          controller.filterByStatus(false, selected);
                                                          controller.applyFilters();
                                                        },
                                                        backgroundColor: Colors.grey.shade100,
                                                        selectedColor: Colors.red.shade100,
                                                        checkmarkColor: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            controller.resetFilters();
                                                            Get.back();
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.grey.shade100,
                                                            foregroundColor: Colors.black87,
                                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                          ),
                                                          child: const Text('Reset'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      barrierColor: Colors.black54,
                                      enableDrag: true,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Products section
                    _buildProductsSection(controller),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoute.itemadd, arguments: {"listcategories": controller.categoreis});
        },
        backgroundColor: AppColor.primaryColor,
        icon: Padding(padding: const EdgeInsets.only(right: 8.0), child: SvgPicture.asset(AppSvg.widgetAddSvgrepoCom, color: Colors.white)),
        label: const Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildHeaderSection(ItemController controller) {
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
                  const Text('Products Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text(
                    '${controller.items.length} items available',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.inventory_2, color: AppColor.primaryColor, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Products', controller.items.length.toString(), Icons.shopping_bag, Colors.blue)),
              const SizedBox(width: 5),
              Expanded(child: _buildStatCard('Categories', controller.categoreis.length.toString(), Icons.category, Colors.green)),
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
              Text(title, style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection(ItemController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(
                '${controller.itemsserch.length} Products',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (controller.itemsserch.isEmpty)
          Container(
            width: double.infinity,
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
                  child: Icon(Icons.inventory_2_outlined, size: 60, color: Colors.grey.shade400),
                ),
                const SizedBox(height: 16),
                const Text('No Products Found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text('Add your first product to get started', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              ],
            ),
          )
        else
          Column(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.itemsserch.length,
                itemBuilder: (context, index) {
                  return Itemwidget(
                    onedit: () async {
                      // await controller.getCategories();
                      print('itemmodel ${controller.itemsserch[index]}, "listcategories": ${controller.categoreis.length}');
                      Get.toNamed(
                        AppRoute.itemupdate,
                        arguments: {"itemModel": controller.itemsserch[index], "listcategories": controller.categoreis},
                      );
                    },
                    ondelete: () {
                      Get.defaultDialog(
                        title: 'Delete Product',
                        titleStyle: const TextStyle(fontSize: 18, color: Colors.red),
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
                              'Are you sure you want to delete this product? This action cannot be undone.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        confirm: ElevatedButton(
                          onPressed: () async {
                            Get.back();
                            await controller.deleteItem(controller.items[index]);
                            await controller.getitems();
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
                    itemModel: controller.itemsserch[index],
                    onActivate: () {
                      controller.toggleProductActive(controller.itemsserch[index]);
                    },
                  );
                },
              ),
              SizedBox(height: 80),
            ],
          ),
      ],
    );
  }
}
