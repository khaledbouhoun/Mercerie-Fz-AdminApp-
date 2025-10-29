import 'dart:convert';

import 'package:admin_ecommerce_app/controller/employe/employe_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/remote/employe_data.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAddController extends GetxController {
  final formstate = GlobalKey<FormState>();
  Crud crud = Crud();
  Dialogfun dialogfun = Dialogfun();
  var employeeController = Get.put<EmployeeController>(EmployeeController());

  final employeeName = TextEditingController();
  final employeePassword = TextEditingController();
  final employeePhone = TextEditingController();

  EmployeeType? selectedEmployeeType;
  List<EmployeeType> employeeTypes = [
    EmployeeType(type: 'Admin', id: '1'),
    EmployeeType(type: 'Responsible', id: '2'),
    EmployeeType(type: 'Preparer', id: '3'),
  ];

  Future<void> addEmployee() async {
    Map<String, dynamic> data = {
      'employee_name': employeeName.text,
      'employee_password': employeePassword.text.trim(),
      'employee_phone': employeePhone.text,
      'employee_type': selectedEmployeeType?.id,
      'employee_active': '1',
    };
    var response = await crud.post(AppLink.employees, data);
    if (response.statusCode == 201) {
      Get.back();
      employeeController.getemployees();
      dialogfun.showSuccessSnack('Success', 'Employee added successfully');
    } else {
      dialogfun.showErrorSnack('Error', response.body['message']);
    }
  }

  @override
  void onClose() {
    employeeName.dispose();
    employeePassword.dispose();
    employeePhone.dispose();
    super.onClose();
  }
}

class EmployeeAddFirestScreenController extends GetxController {
  final formstate = GlobalKey<FormState>();
  Crud crud = Crud();
  Dialogfun dialogfun = Dialogfun();
  final employeeName = TextEditingController();
  final employeePassword = TextEditingController();
  final employeePhone = TextEditingController();

  EmployeeType selectedEmployeeType = EmployeeType(type: 'Admin', id: '1');

  Future<void> addEmployee() async {
    Map<String, dynamic> data = {
      'employee_name': employeeName.text,
      'employee_password': employeePassword.text.trim(),
      'employee_phone': employeePhone.text,
      'employee_type': selectedEmployeeType.id,
      'employee_active': '1',
    };
    var response = await crud.post(AppLink.employees, data);
    print(response);

    if (response.statusCode == 201) {
      Get.offAllNamed('/');
      dialogfun.showSuccessSnack('Success', 'Employee added successfully');
    } else {
      dialogfun.showErrorSnack('Error', response.body['message']);
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
    update();
    var response = await crud.get(AppLink.employees);
    update();
    if (response.statusCode == 200) {
      List employees = response.body['data'];
      if (employees.isNotEmpty) {
        Get.offNamed('/');
      }
    } else {
      dialogfun.showErrorSnack('Error', response.body['message']);
    }
  }
}

class EmployeeType {
  final String type;
  final String id;

  EmployeeType({required this.type, required this.id});
}
