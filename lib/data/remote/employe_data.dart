import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/linkapi.dart';

class EmployeeData {
  Crud crud;
  EmployeeData(this.crud);
  Future<dynamic> getall() async {
    var response = await crud.postData(AppLink.empgetall, {});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> add(Map data) async {
    var response = await crud.postData(AppLink.empadd, data);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> delete(Map data) async {
    var response = await crud.postData(AppLink.empdelete, data);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> toggleStatus(int id, int value) async {
    var response = await crud.postData(AppLink.empToggleStatus, {'id': id.toString(), 'employee_active': value.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
