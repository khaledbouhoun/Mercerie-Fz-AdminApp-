import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Start
    Get.put(Crud());
    
    Get.put(AuthController());
    Get.put(Dialogfun());
  }
}
