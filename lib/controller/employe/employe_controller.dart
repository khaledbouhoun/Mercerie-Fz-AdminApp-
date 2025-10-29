import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/employe_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  Crud crud = Crud();
  Dialogfun dialogfun = Dialogfun();
  List<EmployeModel> employees = [];
  EmployeModel? employee;

  RxBool isLoading = false.obs;

  Future<void> getemployees() async {
    isLoading.value = true;
    try {
      var response = await crud.get(AppLink.employees);
      if (response.statusCode == 200) {
        employees = (response.body['data'] as List).map((e) => EmployeModel.fromJson(e)).toList();
      } else if (response.statusCode == 404) {
        employees = [];
      } else {
        employees = [];
        Get.snackbar(
          'Error',
          response.body['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      employees = [];
      Get.snackbar(
        'Error',
        'An error occurred while fetching employees',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Future<void> getall() async {
  //   var response = await employeeData.getall();
  //   update();
  //   if (response['status'] == 'success') {
  //     employees = (response['data'] as List).map((e) => EmployeModel.fromJson(e)).toList();
  //     update();
  //   } else {
  //     Get.snackbar('Error', response['message'], snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  Color colorfromemployee(int? typeemp) {
    switch (typeemp) {
      case 1:
        return Colors.green;

      case 2:
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }

  Future<void> deleteEmployee(int employeeId) async {
    try {
      var response = await crud.delete('${AppLink.employees}/$employeeId', {});

      if (response.statusCode == 201) {
        // Remove from local list
        employees.removeWhere((element) => element.employeeId == employeeId);
        update();

        Get.back(); // Close details page
        Get.snackbar(
          'Success',
          'Employee deleted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        dialogfun.showErrorSnack('Error', response.body['message'] ?? 'Failed to delete employee');
      }
    } catch (e) {
      print('Error deleting employee: $e');
      dialogfun.showErrorSnack('Error', 'Failed to delete employee: $e');
    }
  }

  Future<void> toggleEmployeeStatus(bool value) async {
    if (employee!.employeeId == null) {
      return;
    }
    var response = await crud.get("${AppLink.employeesToggleStatus}/${employee!.employeeId}");
    update();
    if (response.statusCode == 200) {
      employee!.employeeActive = value == true ? 1 : 0;
      update();
    } else {
      dialogfun.showErrorSnack('Error', response.body['message']);
    }
  }

  String? str;
  Color? color;

  @override
  void onInit() {
    getemployees();
    super.onInit();
  }
}
