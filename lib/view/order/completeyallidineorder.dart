import 'package:admin_ecommerce_app/controller/order/yallidine_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/data/model/yallidine_complete_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';
import 'package:admin_ecommerce_app/widget/orderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompleteYallidineOrder extends StatelessWidget {
  const CompleteYallidineOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const Text(
          'Complete Yallidine Orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.yallidineColor),
        ),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColor.yallidineColor), onPressed: () => Get.back()),
      ),
      body: GetBuilder<CompleteYallidineOrderController>(
        init: CompleteYallidineOrderController(),
        builder: (controller) {
          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Prepared',
                          controller.yallidineOrdersPrepared.length.toString(),
                          Icons.inventory,
                          AppColor.yallidineColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'At Center',
                          controller.yallidineOrdersExpired.length.toString(),
                          Icons.local_shipping,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Delivered',
                          controller.yallidineOrdersDelivered.length.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
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
                            children: [Icon(Icons.inventory, size: 16), SizedBox(width: 6), Text('Préparé')],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.local_shipping, size: 16), SizedBox(width: 6), Text('Centre')],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.check_circle, size: 16), SizedBox(width: 6), Text('Livré (3j)')],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildOrdersList(
                        controller.yallidineOrdersPrepared,
                        controller.isLoading,
                        'No prepared orders found',
                        Icons.inventory,
                        AppColor.yallidineColor,
                      ),
                      _buildOrdersList(
                        controller.yallidineOrdersExpired,
                        controller.isLoading2,
                        'No orders at center found',
                        Icons.local_shipping,
                        Colors.orange,
                      ),
                      _buildOrdersList(
                        controller.yallidineOrdersDelivered,
                        controller.isLoading3,
                        'No delivered orders found',
                        Icons.check_circle,
                        Colors.green,
                      ),
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
          Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black)),
          Text(title, style: TextStyle(fontSize: 10, color: AppColor.grey, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<YallidineCompleteData> orders, bool isLoading, String emptyMessage, IconData icon, Color color) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(40)),
              child: CircularProgressIndicator(color: color, strokeWidth: 3),
            ),
            const SizedBox(height: 16),
            Text('Loading orders...', style: TextStyle(fontSize: 16, color: AppColor.grey, fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(50)),
              child: Icon(icon, size: 50, color: color),
            ),
            const SizedBox(height: 16),
            Text(emptyMessage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black)),
            const SizedBox(height: 8),
            Text(
              'Orders will appear here when available',
              style: TextStyle(fontSize: 14, color: AppColor.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderwidgetYallidineHistory(
          yallidineCompleteData: orders[index],
          completed: true,
          controller: Get.find<YallidineController>(),
        );
      },
    );
  }
}

class CompleteYallidineOrderController extends GetxController {
  List<YallidineCompleteData> yallidineOrdersPrepared = [];
  List<YallidineCompleteData> yallidineOrdersExpired = [];
  List<YallidineCompleteData> yallidineOrdersDelivered = [];
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  Crud crud = Crud();

  OrderData orderData = OrderData(Get.find());

  @override
  void onInit() {
    super.onInit();
    fetchYallidineOrdersCompleted();
    fetchYallidineOrdersExpired();
    fetchYallidineOrdersDelivered();
  }

  Future<void> fetchYallidineOrdersCompleted() async {
    isLoading = true;
    update();

    try {
      var response = await crud.getyallidine("https://api.yalidine.app/v1/parcels/?last_status=En préparation,Expédié");
      if (response['status'] != 'error') {
        print('API Response received: ${response.keys}');
        YallidineCompleteModel completeModel = YallidineCompleteModel.fromJson(response as Map<String, dynamic>);
        yallidineOrdersPrepared = completeModel.data ?? [];
        print('Parsed ${yallidineOrdersPrepared.length} orders');
        print('Parsed $response');
      } else {
        // Handle error case
        print('Error fetching completed orders: ${response['status']}');
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e');
      print('Stack trace: $stackTrace');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchYallidineOrdersExpired() async {
    isLoading2 = true;
    update();

    try {
      var response = await crud.getyallidine(
        "https://api.yalidine.app/v1/parcels/?last_status=Centre,Vers Wilaya,Reçu à Wilaya,En attente du client,Prêt pour livreur,En attente",
      );
      if (response['status'] != 'error') {
        print('API Response received: ${response.keys}');
        YallidineCompleteModel completeModel = YallidineCompleteModel.fromJson(response as Map<String, dynamic>);
        yallidineOrdersExpired = completeModel.data ?? [];
        print('Parsed ${yallidineOrdersExpired.length} orders');
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e');
      print('Stack trace: $stackTrace');
    } finally {
      isLoading2 = false;
      update();
    }
  }

  Future<void> fetchYallidineOrdersDelivered() async {
    isLoading3 = true;
    update();

    try {
      DateTime startDate = DateTime.now().subtract(Duration(days: 3));
      DateTime endDate = DateTime.now();
      String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate);
      String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);
      var response = await crud.getyallidine(
        "https://api.yalidine.app/v1/parcels/?last_status=Livré&date_last_status=$formattedStartDate,$formattedEndDate",
      );
      if (response['status'] != 'error') {
        print('API Response received: ${response.keys}');
        YallidineCompleteModel completeModel = YallidineCompleteModel.fromJson(response as Map<String, dynamic>);
        print(response);
        yallidineOrdersDelivered = completeModel.data ?? [];
        print('Parsed ${yallidineOrdersDelivered.length} orders');
      }
    } catch (e, stackTrace) {
      print('Exception occurred: $e');
      print('Stack trace: $stackTrace');
    } finally {
      isLoading3 = false;
      update();
    }
  }
}
