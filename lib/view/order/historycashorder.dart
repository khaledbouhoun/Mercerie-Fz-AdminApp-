import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/controller/order/cash_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/data/model/cash_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';
import 'package:admin_ecommerce_app/widget/orderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryCashOrder extends StatelessWidget {
  const HistoryCashOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Get.find<AuthController>().selectedEmployee;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text(
          'Cash Order History in 7 days',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.cash),
        ),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColor.cash), onPressed: () => Get.back()),
      ),
      body: GetBuilder<HistoryCashOrderController>(
        init: HistoryCashOrderController(),
        builder: (controller) {
          return Column(
            children: [
              // Stats Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total Orders',
                        controller.historyCashOrders.length.toString(),
                        Icons.shopping_bag,
                        AppColor.cash,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('Completed', controller.historyCashOrders.length.toString(), Icons.check_circle, Colors.green),
                    ),
                    user!.employeeType != 1
                        ? const SizedBox(width: 12)
                        : Expanded(
                          child: _buildStatCard(
                            'Revenue',
                            _calculateTotalRevenue(controller.historyCashOrders),
                            Icons.attach_money,
                            AppColor.bachdjerrah,
                          ),
                        ),
                  ],
                ),
              ),

              // Search and Filter Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColor.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColor.grey.withOpacity(0.3)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search orders...',
                            hintStyle: TextStyle(color: AppColor.grey),
                            prefixIcon: Icon(Icons.search, color: AppColor.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          onChanged: (value) {
                            // Add search functionality here
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(color: AppColor.cash, borderRadius: BorderRadius.circular(12)),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list, color: AppColor.white),
                        onPressed: () {
                          // Add filter functionality here
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Orders List
              Expanded(
                child:
                    controller.historyCashOrders.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: controller.historyCashOrders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Orderwidget(
                                cashmodel: controller.historyCashOrders[index],
                                completed: true,
                                controller: Get.find<CashController>(),
                                history: true,
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 6),
          Text(count, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.black)),
          Text(title, style: TextStyle(fontSize: 10, color: AppColor.grey, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(color: AppColor.cash.withOpacity(0.1), borderRadius: BorderRadius.circular(60)),
            child: Icon(Icons.history, size: 60, color: AppColor.cash),
          ),
          const SizedBox(height: 24),
          Text('No Order History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.black)),
          const SizedBox(height: 8),
          Text('Completed orders will appear here', style: TextStyle(fontSize: 16, color: AppColor.grey), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColor.cash, Colors.green], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, color: AppColor.white),
                  SizedBox(width: 8),
                  Text('Go Back', style: TextStyle(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalRevenue(List<CashModel> orders) {
    double total = 0;
    for (var order in orders) {
      if (order.ordersTotalprice != null) {
        total += order.ordersTotalprice!;
      }
    }
    return '${total.toStringAsFixed(0)} DA';
  }
}

class HistoryCashOrderController extends GetxController {
  List<CashModel> historyCashOrders = [];

  OrderData orderData = OrderData(Get.find());

  @override
  void onInit() {
    super.onInit();
    historyCashOrders = Get.arguments['historyCashOrders'];
    update();
  }
}
