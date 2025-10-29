import 'package:admin_ecommerce_app/core/class/statusrequest.dart';

StatusRequest handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
