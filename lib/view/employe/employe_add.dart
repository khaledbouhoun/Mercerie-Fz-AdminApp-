import 'package:admin_ecommerce_app/controller/employe/employe_add_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/widget/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmployeeAdd extends StatelessWidget {
  const EmployeeAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Add New Employee', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white)),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColor.white), onPressed: () => Get.back()),
      ),
      body: GetBuilder<EmployeeAddController>(
        init: EmployeeAddController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: AppColor.primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(AppSvg.profileAddSvgrepoCom, color: AppColor.white, width: 80, height: 80),
                        const SizedBox(height: 16),
                        const Text('Add New Employee', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white)),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in the employee information below',
                          style: TextStyle(fontSize: 16, color: AppColor.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: controller.formstate,
                    child: Column(
                      children: [
                        // Employee Name Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(AppSvg.user2, color: AppColor.primaryColor, width: 20, height: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Employee Name',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  labeltext: "Enter full name",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(AppSvg.user, color: AppColor.primaryColor, width: 10, height: 10),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeeName,
                                  valid: (value) => value!.isEmpty ? "Please enter employee name" : null,
                                  isNumber: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Employee Phone Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(AppSvg.phoneSvgrepoCom, color: AppColor.primaryColor, width: 20, height: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Phone Number',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  labeltext: "Enter phone number",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(AppSvg.call, color: AppColor.primaryColor, width: 20, height: 20),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeePhone,
                                  valid: (value) => value!.isEmpty ? "Please enter employee phone" : null,
                                  isNumber: true,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Employee Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(
                                        AppSvg.lockKeyholeMinimalisticSvgrepoCom1,
                                        color: AppColor.primaryColor,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Password',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  labeltext: "Enter password",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      AppSvg.lockKeyholeMinimalisticSvgrepoCom,
                                      color: AppColor.primaryColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeePassword,
                                  valid: (value) => value!.isEmpty ? "Please enter employee password" : null,
                                  isNumber: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Employee Type Dropdown
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(AppSvg.bag2, color: AppColor.primaryColor, width: 20, height: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Employee Type',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildTypeOfEmployeeDropdown(controller),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.primaryColor.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
                                if (controller.formstate.currentState!.validate()) {
                                  await controller.addEmployee();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add, color: AppColor.white, size: 24),
                                  SizedBox(width: 12),
                                  Text('Add Employee', style: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeOfEmployeeDropdown(EmployeeAddController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.background,
        border: Border.all(color: AppColor.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EmployeeType>(
          value: controller.selectedEmployeeType,
          hint: Text("Select Employee Type", style: TextStyle(fontSize: 16, color: AppColor.grey)),
          style: const TextStyle(fontSize: 16, color: AppColor.black),
          borderRadius: BorderRadius.circular(16),
          elevation: 5,
          dropdownColor: AppColor.white,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: AppColor.grey),
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

class EmployeeAddFirstScreen extends StatelessWidget {
  const EmployeeAddFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Add New Employee', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white)),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<EmployeeAddFirestScreenController>(
        init: EmployeeAddFirestScreenController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: AppColor.primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(AppSvg.profileAddSvgrepoCom, color: AppColor.white, width: 80, height: 80),
                        const SizedBox(height: 16),
                        const Text('Add New Employee', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white)),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in the employee information below',
                          style: TextStyle(fontSize: 16, color: AppColor.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: controller.formstate,
                    child: Column(
                      children: [
                        // Employee Name Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(AppSvg.user2, color: AppColor.primaryColor, width: 20, height: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Employee Name',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  labeltext: "Enter full name",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(AppSvg.user, color: AppColor.primaryColor, width: 10, height: 10),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeeName,
                                  valid: (value) => value!.isEmpty ? "Please enter employee name" : null,
                                  isNumber: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Employee Phone Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(AppSvg.phoneSvgrepoCom, color: AppColor.primaryColor, width: 20, height: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Phone Number',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  labeltext: "Enter phone number",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(AppSvg.call, color: AppColor.primaryColor, width: 20, height: 20),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeePhone,
                                  valid: (value) => value!.isEmpty ? "Please enter employee phone" : null,
                                  isNumber: true,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Employee Password Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SvgPicture.asset(
                                        AppSvg.lockKeyholeMinimalisticSvgrepoCom1,
                                        color: AppColor.primaryColor,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Password',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                CustomTextForm(
                                  textInputAction: TextInputAction.done,
                                  labeltext: "Enter password",
                                  iconData: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      AppSvg.lockKeyholeMinimalisticSvgrepoCom,
                                      color: AppColor.primaryColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  formstate: controller.formstate,
                                  mycontroller: controller.employeePassword,
                                  valid: (value) => value!.isEmpty ? "Please enter employee password" : null,
                                  isNumber: false,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.primaryColor.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
                                if (controller.formstate.currentState!.validate()) {
                                  await controller.addEmployee();
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person_add, color: AppColor.white, size: 24),
                                  SizedBox(width: 12),
                                  Text('Add Employee', style: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
