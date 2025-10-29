import 'dart:async';

import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/data/model/cartcolor_model.dart';
import 'package:admin_ecommerce_app/data/model/cart_model.dart';
import 'package:admin_ecommerce_app/data/model/cash_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';

import 'package:get/get.dart';

class CashController extends GetxController {
  OrderData orderData = OrderData(Get.find());

  List<CashModel> cashOrders = [];
  List<CashModel> completedCashOrders = [];
  List<CashModel> historyCashOrders = [];
  CashModel? cashselcted;
  bool? cashcompleted;

  // List<CartColorModel> getcolors = [];
  List<CartModel> carts = [];
  int? idemp;

  bool go = false;

  @override
  void onInit() {
    super.onInit();
    idemp = Get.find<AuthController>().selectedEmployee!.employeeId;
    fetchCashOrders();
  }

  Future<void> fetchCashOrders() async {
    try {
      var response = await orderData.cashgetall();
      if (response['status'] == 'success') {
        List list = response['data'];
        cashOrders = list.map((item) => CashModel.fromJson(item)).where((test) => test.ordersStatus! == 1).toList();
        completedCashOrders = list.map((item) => CashModel.fromJson(item)).where((order) => order.ordersStatus! == 2).toList();
        historyCashOrders = list.map((item) => CashModel.fromJson(item)).where((order) => order.ordersStatus! == 3).toList();
      } else {
        print('Error fetching cash orders: ${response['message']}');
      }
      update();
    } catch (e) {
      print('Error fetching : $e');
    }
  }

  // Future<void> tocolor(String orderid) async {
  //   var response = await orderData.cashCartColor(orderid);
  //   print("Response from cashCartColor: $response");
  //   print("=============================== 00000000");
  //   // for (var element in response['data']) {
  //   //   CartColorModel cartColorModel = CartColorModel(
  //   //     cartId: element['cart_id'],
  //   //     clr: <Clr>[for (var c in element['clr']) Clr(colorCode2: c['color_code2'], qty: c['qty'])],
  //   //   );
  //   // }
  //   print("=============================== 1111111");
  //   getcolors = (response['data'] as List).map<CartColorModel>((item) => CartColorModel.fromJson(item)).toList();
  //   print("=============================== 444555");
  // }

  // Map<String, double> colors(String itemsid) {
  //   Map<String, double> colors = {};
  //   for (var element in getcolors) {
  //     if (element.cartId == itemsid) {
  //       for (var clr in element.clr!) {
  //         colors[clr.colorCode2!] = clr.qty!;
  //       }
  //     }
  //   }
  //   return colors;
  // }

  Future<void> view(String orderid, String nameemp) async {
    print("=============================== starrttt");

    carts = [];
    print('kkkkkkkkkkkkkkkkkk$idemp');
    var response = await orderData.cashCart(orderid, idemp.toString(), "1");
    if (response['status'] == "taken") {
      await fetchCashOrders();
      Get.defaultDialog(title: "Order Taken", middleText: "This order has already been taken by $nameemp.");
    } else {
      if (response['status'] == "success") {
        carts = response['data'].map<CartModel>((item) => CartModel.fromJson(item)).toList();
        // await tocolor(orderid);
        go = true;
      } else if (response['status'] == "empty") {
        await fetchCashOrders();
        Get.defaultDialog(title: "Order Empty", middleText: "This order has no items.");
      }
    }

    update();
  }



  void removeCartItem(String id) {
    // carts.removeWhere((cart) => cart.itemsId == id);
    update();
  }

  void removeColorItem(String id) {
    // getcolors.removeWhere((color) => color.cartId == id);
    update();
  }
}
