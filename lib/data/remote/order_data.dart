import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/linkapi.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);

  Future<dynamic> confirmCashOrder(String orderid, String status) async {
    var response = await crud.postData(AppLink.confirmCashOrder, {"order_id": orderid, "status": status});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> confirmYallidineOrder(String orderid, String status, String? weight) async {
    var response = await crud.postData(AppLink.confirmYallidineOrder, {"order_id": orderid, "status": status, "weight": weight});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> cashgetall() async {
    var response = await crud.postData(AppLink.cashgetall, {});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> cashCart(String orderid, String orderemp, String type) async {
    var response = await crud.postData(AppLink.cashCart, {"order_id": orderid, "order_emp": orderemp, "type": type});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> cashCartColor(String orderid) async {
    var response = await crud.postData(AppLink.cashCartColor, {"order_id": orderid});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteItemCart(String cartid) async {
    var response = await crud.postData(AppLink.deleteItemCart, {"cart_id": cartid});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> yallidineCart(String orderid, String orderemp, String type) async {
    var response = await crud.postData(AppLink.yallidineCart, {"order_id": orderid, "order_emp": orderemp, "type": type});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> yallidineCartColor(String orderid) async {
    var response = await crud.postData(AppLink.yallidineCartColor, {"order_id": orderid});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> yallidinegetall() async {
    var response = await crud.postData(AppLink.yallidinegetall, {});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> keepalive(String orderid, String orderemp, String typeorder) async {
    var response = await crud.postData(AppLink.keepalive, {"order_id": orderid, "order_emp": orderemp, "typeorder": typeorder});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> releaseOrder(String orderid, String typeorder) async {
    var response = await crud.postData(AppLink.releaseOrder, {"order_id": orderid, "typeorder": typeorder});
    return response.fold((l) => l, (r) => r);
  }

 
}
