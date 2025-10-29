import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/linkapi.dart';

class AuthData {
  Crud crud;
  AuthData(this.crud);
  Future<dynamic> getemployes() async {
    var response = await crud.postData(AppLink.getemployes, {});
    print(response);
    return response.fold((l) => l, (r) => r);
  }
}
