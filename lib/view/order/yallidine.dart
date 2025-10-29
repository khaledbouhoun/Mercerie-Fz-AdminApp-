import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/controller/order/yallidine_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/data/model/yallidne_model.dart';
import 'package:admin_ecommerce_app/widget/orderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Yallidine extends StatelessWidget {
  const Yallidine({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Get.find<AuthController>().selectedEmployee;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text('Yallidine Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.yallidineColor)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColor.yallidineColor), onPressed: () => Get.back()),
        actions: [
          if (user?.employeeType == 1)
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(color: AppColor.yallidineColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoute.completeyallidineorder);
                },
                icon: const Icon(Icons.check_circle_outline_outlined, color: AppColor.yallidineColor),
              ),
            ),
        ],
      ),
      body: GetBuilder<YallidineController>(
        init: YallidineController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // Stats Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Orders',
                          controller.yallidineOrders.length.toString(),
                          Icons.shopping_bag,
                          AppColor.yallidineColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Completed',
                          controller.completedYaallidineOrders.length.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: TabBar(
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.grey,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColor.yallidineColor, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.list_alt, size: 18), SizedBox(width: 8), Text('All Orders')],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.check_circle, size: 18), SizedBox(width: 8), Text('Completed')],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    children: [
                      // All Orders Tab
                      _buildOrdersList(controller.yallidineOrders, false, controller, 'No orders found'),

                      // Completed Orders Tab
                      _buildCompletedOrdersView(controller),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black)),
          Text(title, style: TextStyle(fontSize: 12, color: AppColor.grey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<YallidineModel> orders, bool completed, YallidineController controller, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: AppColor.yallidineColor.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.inbox_outlined, size: 50, color: AppColor.yallidineColor),
            ),
            const SizedBox(height: 16),
            Text(emptyMessage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black)),
            const SizedBox(height: 8),
            Text('Orders will appear here when available', style: TextStyle(fontSize: 14, color: AppColor.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderwidgetYallidine(yallidineModel: orders[index], completed: completed, controller: controller);
      },
    );
  }

  Widget _buildCompletedOrdersView(YallidineController controller) {
    return Column(
      children: [
        Expanded(child: _buildOrdersList(controller.completedYaallidineOrders, true, controller, 'No completed orders found')),

        // Confirm All Button
        if (controller.completedYaallidineOrders.isNotEmpty)
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColor.yallidineColor, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: AppColor.yallidineColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 12, offset: const Offset(0, 6)),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  controller.createParcels();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: AppColor.white, size: 24),
                    SizedBox(width: 12),
                    Text('Confirm All Orders', style: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
