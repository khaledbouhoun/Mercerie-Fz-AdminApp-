import 'package:admin_ecommerce_app/data/remote/employe_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeUploadController extends GetxController {
  final formstate = GlobalKey<FormState>();
  EmployeeData employeeData = EmployeeData(Get.find());
  final employeeName = TextEditingController();
  final employeePassword = TextEditingController();
  final employeePhone = TextEditingController();
  bool isLoading = false;

  EmployeeType? selectedEmployeeType;
  List<EmployeeType> employeeTypes = [
    EmployeeType(type: 'Admin', id: '1'),
    EmployeeType(type: 'Responsible', id: '2'),
    EmployeeType(type: 'Preparer', id: '3'),
  ];

  Future<void> addEmployee() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      update();
      Map data = {'name': employeeName.text, 'email': employeePassword.text, 'phone': employeePhone.text};
      var response = await employeeData.add(data);
      isLoading = false;
      update();
      if (response['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Employee added successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        Get.snackbar('Error', response['message'], snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  @override
  void onClose() {
    employeeName.dispose();
    employeePassword.dispose();
    employeePhone.dispose();
    super.onClose();
  }

  Future<void> getemployees() async {
    isLoading = true;
    update();
    var response = await employeeData.getall();
    isLoading = false;
    update();
    if (response['status'] == 'success') {
      // Handle successful response
    } else {
      Get.snackbar('Error', response['message'], snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

class EmployeeType {
  final String type;
  final String id;

  EmployeeType({required this.type, required this.id});
}
