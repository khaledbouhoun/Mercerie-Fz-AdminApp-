import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/core/constant/routesstr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header Section
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(24),
              //   decoration: BoxDecoration(
              //     gradient: const LinearGradient(
              //       colors: [AppColor.primaryColor, AppColor.belcourt],
              //       begin: Alignment.topLeft,
              //       end: Alignment.bottomRight,
              //     ),
              //     borderRadius: BorderRadius.circular(20),
              //     boxShadow: [
              //       BoxShadow(color: AppColor.primaryColor.withOpacity(0.3), spreadRadius: 2, blurRadius: 12, offset: const Offset(0, 6)),
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: 80,
              //         height: 80,
              //         decoration: BoxDecoration(color: AppColor.white.withOpacity(0.2), borderRadius: BorderRadius.circular(40)),
              //         child: const Icon(Icons.shopping_cart_checkout, color: AppColor.white, size: 40),
              //       ),
              //       const SizedBox(height: 16),
              //       const Text('Order Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColor.white)),
              //       const SizedBox(height: 8),
              //       Text('Choose your delivery method', style: TextStyle(fontSize: 16, color: AppColor.white.withOpacity(0.9))),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 32),

              // Delivery Options Section
              const Text('Select Delivery Type', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black)),

              const SizedBox(height: 24),

              // Delivery Options Cards
              Expanded(
                child: Column(
                  children: [
                    // Yallidine Delivery Option
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 15, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.toNamed(AppRoute.yallidine);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              children: [
                                // Icon Container
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColor.yallidineColor, Colors.red],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.yallidineColor.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: SvgPicture.asset(AppSvg.truckTickSvgrepoCom2, color: AppColor.white, width: 5, height: 5),
                                  ),
                                ),

                                const SizedBox(width: 20),

                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Yallidine Delivery',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
                                      ),
                                      const SizedBox(height: 8),

                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: AppColor.yallidineColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: AppColor.yallidineColor.withOpacity(0.3)),
                                        ),
                                        child: Text(
                                          'Recommended',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.yallidineColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Arrow Icon
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: AppColor.background, borderRadius: BorderRadius.circular(12)),
                                  child: SvgPicture.asset(AppSvg.r, color: AppColor.yallidineColor, width: 25, height: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Cash on Delivery Option
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 15, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.toNamed(AppRoute.cash);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              children: [
                                // Icon Container
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [AppColor.cash, Colors.green],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.cash.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: SvgPicture.asset(AppSvg.shop2SvgrepoCom, color: AppColor.white, width: 5, height: 5),
                                  ),
                                ),

                                const SizedBox(width: 20),

                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Magazine Delivery',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.black),
                                      ),
                                      const SizedBox(height: 8),

                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: AppColor.cash.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: AppColor.cash.withOpacity(0.3)),
                                        ),
                                        child: Text(
                                          'Instant',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.cash),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Arrow Icon
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: AppColor.background, borderRadius: BorderRadius.circular(12)),
                                  child: SvgPicture.asset(AppSvg.r, color: AppColor.cash, width: 25, height: 25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
