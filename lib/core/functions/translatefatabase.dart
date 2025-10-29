import 'package:admin_ecommerce_app/core/services/services.dart';
import 'package:get/get.dart';

dynamic translateDatabase(columnar, columnen) {
  MyServices myServices = Get.find();

  if (myServices.sharedPreferences.getString("lang") == "ar") {
    return columnar;
  } else {
    return columnen;
  }
}
