import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/cart_model.dart';
import 'package:admin_ecommerce_app/data/model/yallidne_model.dart';
import 'package:admin_ecommerce_app/data/remote/order_data.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class YallidineController extends GetxController {
  OrderData orderData = OrderData(Get.find());
  Crud crud = Crud();
  Dialogfun dialogfun = Get.find<Dialogfun>();

  List<YallidineModel> yallidineOrders = [];
  List<YallidineModel> completedYaallidineOrders = [];
  final List<Map<String, dynamic>> parcelsData = [];

  // List<CartColorModel> getcolors = [];
  List<CartModel> carts = [];
  int? idemp;

  @override
  void onInit() async {
    super.onInit();
    idemp = Get.find<AuthController>().selectedEmployee!.employeeId;
    await fetchYallidineOrders();
  }

  Future<void> fetchYallidineOrders() async {
    try {
      var response = await crud.get(AppLink.yallidine);
      if (response.statusCode == 200) {
        List list = response.body['data'];
        yallidineOrders = list.map((item) => YallidineModel.fromJson(item)).where((test) => test.yStatue! == 1).toList();
        completedYaallidineOrders = list.map((item) => YallidineModel.fromJson(item)).where((order) => order.yStatue! == 2).toList();
      } else if (response.statusCode == 404) {
        yallidineOrders = [];
        completedYaallidineOrders = [];
      }
      update();
    } catch (e) {
      print('Error fetching : $e');
    }
  }

  Future<List<CartModel>> view(YallidineModel yallidineModel, String nameEmp, int type) async {
    try {
      yallidineModel.isLoading = true.obs;
      carts = [];

      final response = await crud.post(AppLink.yallidineDetails, {"order_id": yallidineModel.yId, "order_emp": idemp, "type": type});

      // Example: your backend should return JSON + correct status code
      // 200 → success
      // 404 → not found / empty
      // 409 → already taken
      // 400 → invalid state

      switch (response.statusCode) {
        case 200: // ✅ success
          carts = (response.body['data'] as List<dynamic>).map<CartModel>((item) => CartModel.fromJson(item)).toList();
          yallidineModel.isLoading = false.obs;
          // await tocolor(orderId);
          update();
          return carts;

        case 409: // ⚠️ already taken
          await fetchYallidineOrders();
          dialogfun.showErrorDialog("Order Taken", "This order has already been taken by $nameEmp", () {});
          yallidineModel.isLoading = false.obs;
          update();
          return [];

        case 404: // ❌ not found or empty
          dialogfun.showErrorDialog("Not Found", "No cart items found for this order.", () {});
          yallidineModel.isLoading = false.obs;
          return [];

        case 400: // 🚫 invalid state
          dialogfun.showErrorDialog("Invalid Order", "This order cannot be reserved.", () {});
          yallidineModel.isLoading = false.obs;
          return [];

        default:
          dialogfun.showErrorDialog("Error", "Unexpected server response (code: ${response.statusCode}).", () {});
          yallidineModel.isLoading = false.obs;
          return [];
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", middleText: "An error occurred while fetching order details.");

      return [];
    }
  }

  void removeCartItem(String id) {
    // carts.removeWhere((cart) => cart.itemsId == id);
    update();
  }

  void removeColorItem(String id) {
    // getcolors.removeWhere((color) => color.cartId == id);
    update();
  }

  void creatListPacles() {
    for (var pacle in completedYaallidineOrders) {
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
  }

  Future<void> createParcels() async {
    creatListPacles();
    var response = await crud.postyallidine("https://api.yalidine.app/v1/parcels/", parcelsData) as Map<String, dynamic>;
    print(response);
    String labelsUrl = '';
    for (var orderResult in response.values) {
      if (orderResult['success'] == true) {
        await crud.post(AppLink.yallidineStatus, {"order_id": orderResult['order_id'], "status": 3, "weight": "null"});
        completedYaallidineOrders.removeWhere((pacle) => pacle.yId.toString() == orderResult['order_id']);
        labelsUrl = orderResult['labels'];
      }
    }

    Get.defaultDialog(
      title: "Success",
      middleText: "Parcels created successfully.\n\nDo you want to print all parcel labels?",
      textConfirm: "Go to Labels",
      textCancel: "Cancel",
      onConfirm: () async {
        if (labelsUrl.isNotEmpty) {
          await launchUrl(Uri.parse(labelsUrl));
        }
        Get.back();
      },
      onCancel: () => Get.back(),
    );
    update();
    Get.find<YallidineController>().fetchYallidineOrders();
  }
}
