import 'package:admin_ecommerce_app/controller/chekintime/chekInTime_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChekInTime extends StatelessWidget {
  const ChekInTime({super.key});

  @override
  Widget build(BuildContext context) {
    final ChekintimeController controller = Get.put(ChekintimeController());

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        return SafeArea(
          child:
              controller.isPageLoading.value
                  ? const Center(child: CircularProgressIndicator(color: AppColor.primaryColor, strokeWidth: 2))
                  : CustomScrollView(
                    slivers: [
                      /// Modern App Bar
                      SliverAppBar(
                        expandedHeight: 120,
                        floating: false,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              'Check-In Time',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                            ),
                          ),
                          background: Container(decoration: BoxDecoration()),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Obx(() {
                            return Column(
                              children: [
                                const SizedBox(height: 10),

                                /// 🕒 Modern Time Display Card
                                Container(
                                  padding: const EdgeInsets.all(32),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
                                    ),
                                    borderRadius: BorderRadius.circular(28),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.primaryColor.withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                                        child: SvgPicture.asset(AppSvg.clockSvgrepoCom, color: Colors.white, height: 48),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        '${controller.checkInTimeDate.value.hour.toString().padLeft(2, '0')}:${controller.checkInTimeDate.value.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          fontSize: 56,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 2,
                                          height: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'Current Time',
                                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 32),

                                /// 🗺️ Status Cards with Modern Glass Effect
                                Row(
                                  children: [
                                    /// GPS Status Card
                                    Expanded(
                                      child: _buildStatusCard(
                                        icon: AppSvg.loction,
                                        isActive: controller.nearestStore.value != null,
                                        title:
                                            controller.nearestStore.value != null
                                                ? controller.nearestStore.value!.storesNom ?? 'In Store'
                                                : 'Out of Area',
                                        subtitle: controller.nearestStore.value != null ? 'Location' : 'Not in range',
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    /// Fingerprint Status Card
                                    Expanded(
                                      child: _buildStatusCard(
                                        icon: AppSvg.finger,
                                        isActive: controller.isFingerprintVerified.value,
                                        title: controller.isFingerprintVerified.value ? 'Verified' : 'Not Verified',
                                        subtitle: 'Biometric',
                                      ),
                                    ),
                                  ],
                                ),

                                // const SizedBox(height: 24),

                                // /// 💬 Status Message with Modern Design
                                // if (controller.statusMessage.value.isNotEmpty)
                                //   Container(
                                //     padding: const EdgeInsets.all(20),
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(20),
                                //       border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1.5),
                                //       boxShadow: [
                                //         BoxShadow(color: Colors.blue.withOpacity(0.08), spreadRadius: 0, blurRadius: 15, offset: const Offset(0, 4)),
                                //       ],
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Container(
                                //           padding: const EdgeInsets.all(10),
                                //           decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                                //           child: const Icon(Icons.info_outline, color: Colors.blue, size: 24),
                                //         ),
                                //         const SizedBox(width: 16),
                                //         Expanded(
                                //           child: Text(
                                //             controller.statusMessage.value,
                                //             style: const TextStyle(fontSize: 15, color: Color(0xFF2D3142), fontWeight: FontWeight.w500, height: 1.4),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                const SizedBox(height: 40),

                                /// ✅ Modern Check-In Button
                                Visibility(
                                  visible: controller.checkTime.value == null,
                                  child: Container(
                                    width: double.infinity,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.primaryColor.withOpacity(0.4),
                                          spreadRadius: 0,
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: controller.isLoading.value ? null : () async => await controller.chekInTime(),
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          child:
                                              controller.isLoading.value
                                                  ? const Center(
                                                    child: SizedBox(
                                                      height: 28,
                                                      width: 28,
                                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                                    ),
                                                  )
                                                  : Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.2),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: const Icon(Icons.login_rounded, size: 24, color: Colors.white),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      const Text(
                                                        'Check In Now',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
        );
      }),
    );
  }

  Widget _buildStatusCard({required String icon, required bool isActive, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isActive ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: (isActive ? Colors.green : Colors.red).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: (isActive ? Colors.green : Colors.red).withOpacity(0.1), shape: BoxShape.circle),
            child: SvgPicture.asset(icon, color: isActive ? Colors.green : Colors.red, height: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: isActive ? Colors.green : Colors.red, fontSize: 15, fontWeight: FontWeight.bold, height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
