// lib/controllers/auth_controller.dart
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:admin_ecommerce_app/data/model/employe_model.dart';
import 'package:admin_ecommerce_app/data/model/stores_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/view/employe/employe_add.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Crud crud = Crud();

  Dialogfun dialogfun = Dialogfun();
  List<EmployeModel> employees = [];
  EmployeModel? selectedEmployee;
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool hidePassword = true.obs;
  RxList<StoresModel> stores = <StoresModel>[].obs;

  @override
  void onInit() async {
    await getEmployees();
    await fetchStores();
    super.onInit();
  }

  Future<void> getEmployees() async {
    selectedEmployee = null;
    passwordController.clear();
    employees.clear();
    isLoading.value = true;
    try {
      var response = await crud.get(AppLink.employees);
      if (response.statusCode == 200) {
        employees = (response.body['data'] as List).map((e) => EmployeModel.fromJson(e)).toList();
        if (employees.isNotEmpty) {
          selectedEmployee = employees.first;
        }
      } else if (response.statusCode == 404) {
        Get.off(() => EmployeeAddFirstScreen());
      } else {
        dialogfun.showErrorDialog('Error', 'Failed to load employees', () {});
      }
      update();
    } catch (e) {
      dialogfun.showErrorDialog('Error', 'An error occurred: $e', () {});
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> authenticate() async {
    if (selectedEmployee == null) {
      dialogfun.showErrorSnack('Wrong', 'please select an employee');
      return;
    }

    // if (passwordController.text.isEmpty) {
    //   dialogfun.showErrorSnack("Incorrect","Email or password is incorrect");
    //   return;
    // }

    isLoading.value = true;
    var response = await crud.post(AppLink.employeesLogin, {
      'employee_id': selectedEmployee!.employeeId,
      'employee_password': passwordController.text,
    });
    if (response.statusCode == 200) {
      await Get.offNamed(AppRoute.home);
    } else if (response.statusCode == 401) {
      dialogfun.showErrorSnack("Incorrect", "Password Incorrect");
      isLoading.value = false;
    } else {
      dialogfun.showErrorSnack("Error", "An error occurred during login");
      isLoading.value = false;
      return;
    }
    isLoading.value = false;
  }

  Future<void> fetchStores() async {
    try {
      var response = await crud.get(AppLink.stores);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.body as List;
        stores.value = data.map((json) => StoresModel.fromJson(json)).toList();
        print('✅ Stores fetched: ${stores.length}');
      } else {
        stores.clear();
      }
    } catch (e) {
      print('❌ Error fetching stores: $e');
      stores.clear();
    }
  }
}
