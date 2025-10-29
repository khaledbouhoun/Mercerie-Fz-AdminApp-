import 'package:admin_ecommerce_app/controller/employe/employe_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/widget/backwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EmployeDetails extends StatelessWidget {
  final Color color;
  const EmployeDetails({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EmployeeController>();
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Employee Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white)),
        backgroundColor: color,
        elevation: 0,
        centerTitle: true,

        leading: Backwidget(color: AppColor.white),
      ),
      body: GetBuilder<EmployeeController>(
        init: EmployeeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: color),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(AppSvg.userIdSvgrepoCom, color: AppColor.white, width: 80, height: 80),
                        const SizedBox(height: 16),
                        Text(
                          controller.employee!.employeeName ?? 'No Name',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Employee ID: ${controller.employee!.employeeId}',
                          style: TextStyle(fontSize: 16, color: AppColor.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.white.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppSvg.user2, color: AppColor.white, width: 16, height: 16),
                              const SizedBox(width: 8),
                              Text(
                                _getEmployeeTypeText(controller.employee!.employeeType),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoCard(controller),
                      const SizedBox(height: 16),
                      _buildStatusCard(controller),
                      const SizedBox(height: 16),
                      _builddeleteCard(context, controller),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _builddeleteCard(BuildContext context, EmployeeController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
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
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, color: color, width: 20, height: 20),
                ),
                const SizedBox(width: 12),
                const Text('Delete Employee', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black)),
              ],
            ),
            const SizedBox(height: 20),
            Text('Are you sure you want to delete this employee?', style: TextStyle(fontSize: 14, color: AppColor.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warning,
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    _showDeleteConfirmation(context, controller);
                  },
                  child: const Text('Delete Employee', style: TextStyle(color: AppColor.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getEmployeeTypeText(int? type) {
    switch (type) {
      case 1:
        return "Administrator";
      case 2:
        return "Responsable";
      default:
        return "Preparing";
    }
  }

  Widget _buildInfoCard(EmployeeController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
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
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: SvgPicture.asset(AppSvg.user2, color: color, width: 20, height: 20),
                ),
                const SizedBox(width: 12),
                const Text('Contact Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black)),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              SvgPicture.asset(AppSvg.call, color: color, width: 20, height: 20),
              'Phone Number',
              controller.employee!.employeePhone ?? 'N/A',
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icon(Icons.calendar_today, color: color, size: 20), 'Join Date', controller.employee!.employeeDate ?? 'N/A'),
            const SizedBox(height: 16),
            _buildInfoRow(Icon(Icons.badge, color: color, size: 20), 'Employee ID', controller.employee!.employeeId?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(Widget icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: icon,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: AppColor.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(EmployeeController controller) {
    bool isActive = controller.employee!.employeeActive == 1;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
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
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.toggle_on_outlined, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Employee Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (isActive ? Colors.green : Colors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: (isActive ? Colors.green : Colors.red).withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isActive ? 'Active' : 'Inactive',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isActive ? Colors.green : Colors.red),
                      ),
                      Text(
                        isActive ? 'Employee is currently active' : 'Employee is currently inactive',
                        style: TextStyle(fontSize: 14, color: AppColor.grey),
                      ),
                    ],
                  ),
                  Switch(
                    value: isActive,
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                    inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    onChanged: (value) {
                      controller.toggleEmployeeStatus(value);
                      controller.update();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, EmployeeController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColor.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.warning, color: AppColor.warning, size: 24),
              ),
              const SizedBox(width: 12),
              const Text('Delete Employee', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Are you sure you want to delete ${controller.employee!.employeeName}? This action cannot be undone.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel', style: TextStyle(color: AppColor.grey))),
            Container(
              decoration: BoxDecoration(color: AppColor.warning, borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.deleteEmployee(controller.employee!.employeeId!);
                },
                child: const Text('Delete', style: TextStyle(color: AppColor.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}
