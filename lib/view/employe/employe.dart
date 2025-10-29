import 'package:admin_ecommerce_app/controller/employe/employe_controller.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/employe_model.dart';
import 'package:admin_ecommerce_app/view/employe/employe_add.dart';
import 'package:admin_ecommerce_app/view/employe/employe_details.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      body: GetBuilder<EmployeeController>(
        init: EmployeeController(),
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Search and Filter Section
                  Text('Employees Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(child: _buildStatCard('Total', controller.employees.length.toString(), Icons.people, AppColor.primaryColor)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Active',
                          controller.employees.where((e) => e.employeeActive == 1).length.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Prearing',
                          controller.employees.where((e) => e.employeeType == 3).length.toString(),
                          Icons.pending,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Employees List
                  Expanded(
                    child: Obx(
                      () =>
                          controller.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : controller.employees.isNotEmpty
                              ? ListView.builder(
                                itemCount: controller.employees.length,
                                itemBuilder: (context, index) {
                                  return _buildEmployeeCard(controller.employees[index], controller);
                                },
                              )
                              : Center(child: Text('No Employees Found')),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const EmployeeAdd());
        },
        backgroundColor: AppColor.primaryColor,
        icon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SvgPicture.asset(AppSvg.profileAddSvgrepoCom, color: Colors.white),
        ),
        label: const Text("Add Employee", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.black)),
          Text(title, style: TextStyle(fontSize: 12, color: AppColor.grey, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeModel employee, EmployeeController controller) {
    String? employeeType;
    Color? typeColor;
    String? typeIcon;

    switch (employee.employeeType) {
      case 1:
        employeeType = "Admin";
        typeColor = Colors.green;
        typeIcon = AppSvg.user2;
        break;
      case 2:
        employeeType = "Responable";
        typeColor = Colors.blue;
        typeIcon = AppSvg.bag2;
        break;
      default:
        employeeType = "Preparing";
        typeColor = Colors.orange;
        typeIcon = AppSvg.documentAddSvgrepoCom;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            controller.employee = employee;
            controller.update();
            Get.to(() => EmployeDetails(color: controller.colorfromemployee(employee.employeeType!)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [typeColor, typeColor.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: typeColor.withOpacity(0.3), spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: SvgPicture.asset(typeIcon, color: Colors.white, width: 20, height: 20),
                ),

                const SizedBox(width: 16),

                // Employee Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.employeeName ?? 'No Name',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(employee.employeePhone ?? 'No Phone', style: TextStyle(fontSize: 14, color: AppColor.grey)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: typeColor, width: 1),
                        ),
                        child: Text(employeeType, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: typeColor)),
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: AppColor.background, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.arrow_forward_ios, color: AppColor.grey, size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
