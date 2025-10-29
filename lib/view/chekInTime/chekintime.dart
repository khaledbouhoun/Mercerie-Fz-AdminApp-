import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/chekintime/chekInTime_controller.dart';

class ChekInTime extends StatelessWidget {
  const ChekInTime({super.key});

  @override
  Widget build(BuildContext context) {
    final ChekintimeController controller = Get.put(ChekintimeController());

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Check-In Time', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return Column(
            children: [
              const SizedBox(height: 20),
              // Time Card
              Container(
                padding: const EdgeInsets.all(25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 5, blurRadius: 15, offset: const Offset(0, 3))],
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(AppSvg.clockSvgrepoCom, color: AppColor.primaryColor, height: 50),
                    const SizedBox(height: 16),
                    Text(
                      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Status Cards
              Row(
                children: [
                  // GPS Status Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(AppSvg.loction, color: controller.isAtStore.value ? Colors.green : Colors.red, height: 50),

                          const SizedBox(height: 20),
                          Text(
                            controller.isAtStore.value ? 'At Store' : 'Not at Store',
                            style: TextStyle(
                              color: controller.isAtStore.value ? Colors.green : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Fingerprint Status Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppSvg.finger,
                            height: 50,
                            color: controller.isFingerprintVerified.value ? Colors.green : Colors.red,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            controller.isFingerprintVerified.value ? 'Verified' : 'Not Verified',
                            style: TextStyle(
                              color: controller.isFingerprintVerified.value ? Colors.green : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Status Message
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                child: Text(
                  controller.statusMessage.value,
                  style: const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),

              // Check In Button
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: controller.chekInTime,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                  child:
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator(color: Colors.white))
                          : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login, size: 24, color: Colors.white),
                              SizedBox(width: 12),
                              Text('Check In', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
