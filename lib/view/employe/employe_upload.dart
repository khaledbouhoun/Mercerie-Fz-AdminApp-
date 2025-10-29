import 'package:admin_ecommerce_app/controller/employe/employe_add_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/widget/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeUpload extends StatelessWidget {
  const EmployeUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800])),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
      ),
      body: GetBuilder<EmployeeAddController>(
        init: EmployeeAddController(),
        builder: (controller) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextForm(
                        labeltext: "Employee Name",
                        iconData: const Icon(Icons.person),
                        formstate: controller.formstate,
                        mycontroller: controller.employeeName,
                        valid: (value) => value!.isEmpty ? "Please enter employee name" : null,
                        isNumber: false,
                      ),
                      CustomTextForm(
                        labeltext: "Employee Phone",
                        iconData: const Icon(Icons.phone),
                        formstate: controller.formstate,
                        mycontroller: controller.employeePhone,
                        valid: (value) => value!.isEmpty ? "Please enter employee phone" : null,
                        isNumber: true,
                      ),
                      CustomTextForm(
                        textInputAction: TextInputAction.done,

                        labeltext: "Employee Password",
                        iconData: const Icon(Icons.lock),
                        formstate: controller.formstate,
                        mycontroller: controller.employeePassword,
                        valid: (value) => value!.isEmpty ? "Please enter employee password" : null,
                        isNumber: false,
                      ),
                      const SizedBox(height: 16),
                      _buildTypeOfEmployeeDropdown(controller),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeOfEmployeeDropdown(EmployeeAddController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(border: Border.all(color: AppColor.primaryColor, width: 1.5), borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EmployeeType>(
          value: controller.selectedEmployeeType,
          hint: const Text("Select Employee Type", style: TextStyle(fontSize: 16, color: Colors.grey)),
          style: const TextStyle(fontSize: 16, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          dropdownColor: Colors.white,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items:
              controller.employeeTypes.map((EmployeeType type) {
                return DropdownMenuItem<EmployeeType>(value: type, child: Text(type.type, style: const TextStyle(fontSize: 16)));
              }).toList(),
          onChanged: (EmployeeType? newValue) {
            controller.selectedEmployeeType = newValue;
            controller.update();
          },
        ),
      ),
    );
  }
}
