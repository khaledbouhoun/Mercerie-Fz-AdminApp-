import 'dart:async';
import 'package:admin_ecommerce_app/controller/order/yallidine_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/cart_model.dart';
import 'package:admin_ecommerce_app/data/model/yallidne_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsYallidineController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  Dialogfun dialogfun = Get.find<Dialogfun>();
  Crud crud = Crud();

  TextEditingController weight = TextEditingController();
  Timer? _heartbeatTimer;
  late YallidineModel? yallidineselcted;
  late List<CartModel> carts = [];
  late int? idemp;
  late bool? iscompleted;
  List<Map<String, dynamic>> parcelsData = [];
  List<bool> isChecked = [];

  @override
  void onInit() {
    super.onInit();
    idemp = Get.arguments["idemp"];
    yallidineselcted = Get.arguments["yallidineselcted"];
    carts = Get.arguments["carts"];
    print("carts length in details---> ${carts.length}");
    print("carts length in details-qadfqd--> ${carts.first.clr!.length}");
    for (var cart in carts) {
      print("Cart ID: ${cart.prdId}, Colors: ${cart.clr?.map((c) => c.color).join(', ')}");
    }
    isChecked = List<bool>.filled(carts.length, false);
    iscompleted = Get.arguments["yallidinecompleted"];
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
      crud.post(AppLink.yallidineKeepAlive, {"order_id": yallidineselcted!.yId, "order_emp": idemp});
    } catch (e) {
      print("Failed to send heartbeat: $e");
      // يمكنك هنا التعامل مع الخطأ، ربما إظهار رسالة للعامل بأن الاتصال ضعيف
    }
  }

  // الوظيفة التي تحاول تحرير الطلب عند الخروج بشكل طبيعي
  Future<bool> releaseOrderOnExit() async {
    try {
      var response = await crud.post(AppLink.yallidineRelease, {"order_id": yallidineselcted!.yId});
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
          onPressed: () {
            Get.back(result: true);
            releaseOrderOnExit();
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

  // Future<void> onpop2() async {
  //   try {
  //     Get.defaultDialog(
  //       title: "Exit",
  //       middleText: "Are you sure you want to cancel the order?",
  //       confirm: ElevatedButton(
  //         onPressed: () async {
  //           Get.back();
  //           await releaseOrderOnExit();
  //         },
  //         child: const Text("Yes"),
  //       ),
  //       cancel: ElevatedButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         child: const Text("No"),
  //       ),
  //       backgroundColor: Colors.white,
  //       radius: 10,
  //       titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  //       middleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
  //       barrierDismissible: false,
  //     );
  //   } catch (e) {}
  // }

  Future<void> confirmOrder() async {
    try {
      var response = await crud.post(AppLink.yallidineStatus, {
        "order_id": yallidineselcted!.yId!.toString(),
        "status": 2,
        "weight": weight.text,
      });
      if (response.statusCode == 201) {
        Get.back();
        Get.find<YallidineController>().fetchYallidineOrders();
      } else {
        dialogfun.showErrorDialog("Error", "Failed to confirm the order.", () {});
      }
    } catch (e) {
      dialogfun.showErrorDialog("Error", "An error occurred while confirming the order.", () {});
    }
  }

  void creatPacles(YallidineModel pacle) {
    // print("pacle.yId---> ${pacle.yId}");
    // print("pacle.yPrenome---> ${pacle.yPrenome}");
    // print("pacle.yName---> ${pacle.yName}");
    // print("pacle.yTel---> ${pacle.yTel}");
    // print("pacle.yAgenceAdresse---> ${pacle.yAgenceAdresse}");
    // print("pacle.yComunue---> ${pacle.yComunue}");
    // print("pacle.yWilaya---> ${pacle.yWilaya}");
    // print("pacle.yTotalprice---> ${pacle.yTotalprice}");
    // print("pacle.yDelvreytype---> ${pacle.yDelvreytype}");
    // print("pacle.stopdeskid---> ${pacle.stopdeskid}");
    // print("pacle.yWeight---> ${pacle.yWeight}");
    parcelsData.add({
      "order_id": pacle.yId.toString(),
      "from_wilaya_name": "Alger",
      "firstname": pacle.yPrenome,
      "familyname": pacle.yName,
      "contact_phone": pacle.yTel,
      "address": pacle.yAgenceAdresse,
      "to_commune_name": pacle.yComunue,
      "to_wilaya_name": pacle.yWilaya,
      "product_list": "mercerie",
      "price": pacle.yTotalprice,
      "do_insurance": false,
      "declared_value": pacle.yTotalprice,
      "height": 0,
      "width": 0,
      "length": 0,
      "weight": pacle.yWeight,
      "freeshipping": false,
      //is_stopdesk 1 => center
      "is_stopdesk": pacle.yDelvreytype == 1 ? true : false,
      "stopdesk_id": pacle.stopdeskid,
      "has_exchange": false,
    });
  }

  Future<void> createParcels(YallidineModel pacle) async {
    try {
      creatPacles(pacle);
      var response = await crud.postyallidine("https://api.yalidine.app/v1/parcels/", parcelsData);
      print(response);
      response.forEach((orderKey, orderResult) async {
        print("OrderKey: $orderKey, Result: $orderResult\n");
        if (orderResult['success'] == true) {
          // Optionally show success dialog with tracking/label info
          String tracking = orderResult['tracking'] ?? '';
          String labelUrl = orderResult['label'] ?? '';
          String labelsUrl = orderResult['labels'] ?? '';
          await crud.post(AppLink.yallidineStatus, {"order_id": orderResult['order_id'], "status": 3});
          dialogfun.showSuccessDialog(
            "Order Success",
            "Order ${orderResult['order_id']} processed successfully.\nTracking: $tracking\nLabel: $labelUrl\nLabels: $labelsUrl",
            () {},
          );
        } else {
          String message = orderResult['message'] ?? 'Unknown error';
          dialogfun.showErrorDialog("Order Failed", "Order ${orderResult['order_id']} failed.\n$message", () {});
        }
      });
      update();
      Get.back();
      Get.find<YallidineController>().fetchYallidineOrders();
    } catch (e) {
      print(e);
      dialogfun.showErrorDialog("Error", "An error occurred while creating parcels.", () {});
    }
  }

  Future<void> yallidineDeleteItemCart(String cartid) async {
    var response = await orderData.deleteItemCart(cartid);
    if (response['status'] == "success") {
      carts.removeWhere((e) => e.prdId.toString() == cartid);
      update();
    } else {
      print('Error deleting item: ${response['message']}');
    }
  }
}
