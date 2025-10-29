import 'dart:async';
import 'package:admin_ecommerce_app/controller/order/cash_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/data/model/cart_model.dart';
import 'package:admin_ecommerce_app/data/model/cash_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  Crud crud = Crud();
  Dialogfun dialogfun = Get.find<Dialogfun>();
  Timer? _heartbeatTimer;
  late CashModel? cashselcted;
  late List<CartModel> carts = [];
  late int? idemp;
  late bool? iscompleted;
  late bool? history;
  late Color colorshop = AppColor.cash;

  List<bool> isChecked = [];

  @override
  void onInit() {
    super.onInit();
    history = Get.arguments["history"];
    print("history: $history");
    idemp = Get.arguments["idemp"];
    cashselcted = Get.arguments["cashselcted"];
    carts = Get.arguments["carts"];
    isChecked = List<bool>.filled(carts.length, false);
    iscompleted = Get.arguments["cashcompleted"];
    colorshop = cashselcted!.shop == 1 ? AppColor.bachdjerrah : AppColor.belcourt;
    if (iscompleted == false) {
      _startHeartbeat();
    }
  }

  @override
  void onClose() {
    _heartbeatTimer?.cancel();
    super.onClose();
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel(); // ألغِ أي مؤقت قديم أولاً
    _heartbeatTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      print('------------${timer.tick}');
      // قم باستدعاء API النبضة هنا
      _sendKeepAliveRequest();
      print("Sending heartbeat...");
    });
  }

  Future<void> _sendKeepAliveRequest() async {
    try {
      crud.post(AppLink.yallidineKeepAlive, {"order_id": cashselcted!.ordersId, "order_emp": idemp});
    } catch (e) {
      print("Failed to send heartbeat: $e");
      // يمكنك هنا التعامل مع الخطأ، ربما إظهار رسالة للعامل بأن الاتصال ضعيف
    }
  }

  // الوظيفة التي تحاول تحرير الطلب عند الخروج بشكل طبيعي
  Future<bool> releaseOrderOnExit() async {
    try {
      var response = await crud.post(AppLink.yallidineRelease, {"order_id": cashselcted!.ordersId});
      print("order_id sent: ${cashselcted!.ordersId}");
      print('Release response: ${response.body}');
      print('Release response status code: ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        dialogfun.showErrorDialog("Error", "Failed to release the order.", () {});
        return false;
      }
    } catch (e) {
      dialogfun.showErrorDialog("Error", "An error occurred while releasing the order.", () {});
      return false;
    }
  }

  void onchange(int index, bool value) {
    isChecked[index] = value;
    update();
  }

  Future<bool> onpop() async {
    try {
      final result = await Get.defaultDialog<bool>(
        title: "Exit",
        middleText: "Are you sure you want to cancel the order?",
        confirm: ElevatedButton(
          onPressed: () async {
            bool result = await releaseOrderOnExit();
            print('Release order result: $result');
            // Get.back(result: result);
          },
          child: const Text("Yes"),
        ),
        cancel: ElevatedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text("No"),
        ),
        backgroundColor: Colors.white,
        radius: 10,
        titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        middleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        barrierDismissible: false,
      );

      return result ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> onpop2() async {
    try {
      Get.defaultDialog(
        title: "Exit",
        middleText: "Are you sure you want to cancel the order?",
        confirm: ElevatedButton(
          onPressed: () async {
            Get.back();
            await releaseOrderOnExit();
            Get.back();
          },
          child: const Text("Yes"),
        ),
        cancel: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("No"),
        ),
        backgroundColor: Colors.white,
        radius: 10,
        titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        middleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        barrierDismissible: false,
      );
    } catch (e) {}
  }

  Future<void> confirmOrder() async {
    try {
      var response = await crud.post(AppLink.yallidineStatus, {"order_id": cashselcted!.ordersId, "status": 2});
      if (response.statusCode == 201) {
        dialogfun.showSuccessDialog("Success", "Order confirmed successfully.", () {});
        Get.find<CashController>().fetchCashOrders(); // Refresh the list after confirming the order
      } else {
        dialogfun.showErrorDialog("Error", "Error confirming order: ${response.body['message']}", () {});
      }
    } catch (e) {
      print('Error confirming order: $e');
      dialogfun.showErrorDialog("Error", "Error confirming order: $e", () {});
    }
  }

  Future<void> confirmOrderComplete() async {
    try {
      var response = await crud.post(AppLink.yallidineStatus, {"order_id": cashselcted!.ordersId, "status": 3});
      if (response.statusCode == 201) {
        print('Order confirmed successfully');
        Get.back();
        Get.find<CashController>().fetchCashOrders(); // Refresh the list after confirming the order
      } else {
        dialogfun.showErrorDialog("Error", "Error confirming order: ${response.body['message']}", () {});
      }
    } catch (e) {
      dialogfun.showErrorDialog("Error", "An error occurred while confirming the order.", () {});
    }
  }

  Future<void> cashDeleteItemCart(String cartid) async {
    var response = await orderData.deleteItemCart(cartid);
    if (response['status'] == "success") {
      carts.removeWhere((e) => e.prdId.toString() == cartid);
      update();
    } else {
      print('Error deleting item: ${response['message']}');
    }
  }
}
