import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/controller/order/cash_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/widget/orderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cash extends StatelessWidget {
  const Cash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text('Cash Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.cash)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColor.cash), onPressed: () => Get.back()),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: AppColor.cash.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: IconButton(
              icon: const Icon(Icons.history, color: AppColor.cash),
              onPressed: () {
                Get.toNamed(AppRoute.historycash, arguments: {'historyCashOrders': Get.find<CashController>().historyCashOrders});
              },
            ),
          ),
        ],
      ),
      body: GetBuilder<CashController>(
        init: CashController(),
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
                        child: _buildStatCard('Total Orders', controller.cashOrders.length.toString(), Icons.shopping_bag, AppColor.cash),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Completed',
                          controller.completedCashOrders.length.toString(),
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
                          colors: [AppColor.cash, Colors.green],
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
                      _buildOrdersList(controller.cashOrders, false, controller, 'No cash orders found'),

                      // Completed Orders Tab
                      _buildCompletedOrdersList(controller.completedCashOrders, true, controller, 'No completed orders found'),
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

  Widget _buildOrdersList(List orders, bool completed, CashController controller, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: AppColor.cash.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
              child: Icon(Icons.inbox_outlined, size: 50, color: AppColor.cash),
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
        return Orderwidget(cashmodel: orders[index], completed: completed, controller: controller, history: false);
      },
    );
  }

  Widget _buildCompletedOrdersList(List orders, bool completed, CashController controller, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.check_circle_outline, size: 50, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(emptyMessage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black)),
            const SizedBox(height: 8),
            Text('Completed orders will appear here', style: TextStyle(fontSize: 14, color: AppColor.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Orderwidget(cashmodel: orders[index], completed: completed, controller: controller);
      },
    );
  }
}
