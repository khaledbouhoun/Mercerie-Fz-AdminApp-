import 'dart:async';
import 'package:admin_ecommerce_app/controller/auth_controller.dart';
import 'package:admin_ecommerce_app/controller/category/category_controller.dart'; // Import the controller
import 'package:admin_ecommerce_app/controller/employe/employe_controller.dart';
import 'package:admin_ecommerce_app/controller/item/item_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/employe_model.dart';
import 'package:admin_ecommerce_app/view/category/category.dart';
import 'package:admin_ecommerce_app/view/chekInTime/chekintime.dart';
import 'package:admin_ecommerce_app/view/employe/employe.dart';
import 'package:admin_ecommerce_app/view/items/items.dart';
import 'package:admin_ecommerce_app/view/order/order.dart';
import 'package:admin_ecommerce_app/view/stats/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import Get
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) {
        return Scaffold(
          body: PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) return;
              final shouldPop = await controller.onpop();
              if (shouldPop) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: Obx(() {
              if (controller.pages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.selectedIndex.value >= controller.pages.length) {
                controller.selectedIndex.value = 0;
              }
              return controller.pages[controller.selectedIndex.value];
            }),
          ),

          bottomNavigationBar: Obx(() {
            if (controller.pages.isEmpty || controller.pages.length <= 1) {
              return const SizedBox.shrink();
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),
                ],
              ),

              child: GNav(
                // gap: 2,
                activeColor: Colors.white,
                curve: Curves.easeInOut,
                // rippleColor: AppColor.primaryColor.withOpacity(0.2),
                // hoverColor: AppColor.primaryColor.withOpacity(0.2),
                backgroundColor: Colors.white,
                color: AppColor.primaryColor,
                tabBorderRadius: 16,
                duration: const Duration(milliseconds: 400),
                iconSize: 24,
                // tabBackgroundColor: AppColor.primaryColor.withOpacity(0.2),
                tabs: List.generate(
                  controller.pages.length,
                  (index) => GButton(
                    icon: Icons.home, // This is still required, but will be hidden by the custom leading
                    // text: 'Home',
                    textColor: AppColor.primaryColor,
                    textSize: 15,
                    activeBorder: Border.all(color: AppColor.primaryColor),
                    leading: controller.ledingPages[index],
                  ),
                ),

                selectedIndex: controller.selectedIndex.value,
                onTabChange: (index) {
                  controller.changeIndex(index);
                  if (controller.selectedEmployee!.employeeType == 1) {
                    switch (index) {
                      case 0:
                        if (Get.isRegistered<CategoryController>()) {
                          Get.find<CategoryController>().getCategories();
                        }
                        break;
                      case 1:
                        if (Get.isRegistered<ItemController>()) {
                          Get.find<ItemController>().getitems();
                          Get.find<ItemController>().resetFilters();
                          Get.find<ItemController>().getCategories();
                        }
                        break;
                      case 4:
                        if (Get.isRegistered<EmployeeController>()) {
                          Get.find<EmployeeController>().getemployees();
                        }
                        break;
                      default:
                    }
                  } else if (controller.selectedEmployee!.employeeType == 2) {
                    switch (index) {
                      case 0:
                        if (Get.isRegistered<CategoryController>()) {
                          Get.find<CategoryController>().getCategories();
                        }
                        break;
                      case 1:
                        if (Get.isRegistered<ItemController>()) {
                          Get.find<ItemController>().getitems();
                          Get.find<ItemController>().getCategories();
                        }
                        break;
                      default:
                    }
                  }
                },
              ),
            );
          }),
        );
      },
    );
  }
}

class HomeScreenController extends GetxController {
  EmployeModel? selectedEmployee;
  RxInt selectedIndex = 0.obs;
  // Fix: Change the initialization to use RxList<dynamic> or RxList<Widget>
  RxList<Widget> pages = RxList<Widget>();
  List<Widget> ledingPages = [];
  // List<IconData> icons = [];
  bool exit = false;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void showPageAcesse() {
    // Clear existing pages, titles, and icons first
    pages.clear();
    ledingPages.clear();

    if (selectedEmployee != null) {
      if (selectedEmployee!.employeeType == 1) {
        pages.addAll([const Category(), const Item(), const Dashboard(), const Order(), const EmployeePage()]);
        ledingPages.addAll([
          SvgPicture.asset(
            selectedIndex.value == 0 ? AppSvg.folderWithFilesSvgrepoCom : AppSvg.folderWithFilesSvgrepoCom2,
            color: AppColor.primaryColor, // Optional: set color if your SVG is single-color
          ),
          SvgPicture.asset(selectedIndex.value == 1 ? AppSvg.widget2SvgrepoCom : AppSvg.widget2SvgrepoCom1, color: AppColor.primaryColor),
          SvgPicture.asset(selectedIndex.value == 2 ? AppSvg.chartSvgrepoCom1 : AppSvg.chartSvgrepoCom, color: AppColor.primaryColor),
          SvgPicture.asset(selectedIndex.value == 3 ? AppSvg.truckSvgrepoCom : AppSvg.truckTickSvgrepoCom2, color: AppColor.primaryColor),
          SvgPicture.asset(selectedIndex.value == 4 ? AppSvg.user2 : AppSvg.user, color: AppColor.primaryColor),
        ]);
        selectedIndex.value = 2;
      } else if (selectedEmployee!.employeeType == 2) {
        pages.addAll([const Category(), const Item(), const Order(), const ChekInTime()]);
        ledingPages.addAll([
          SvgPicture.asset(
            selectedIndex.value == 0 ? AppSvg.folderWithFilesSvgrepoCom : AppSvg.folderWithFilesSvgrepoCom2,
            color: AppColor.primaryColor,
          ),
          SvgPicture.asset(selectedIndex.value == 1 ? AppSvg.widget2SvgrepoCom : AppSvg.widget2SvgrepoCom1, color: AppColor.primaryColor),
          SvgPicture.asset(selectedIndex.value == 2 ? AppSvg.truckSvgrepoCom : AppSvg.truckTickSvgrepoCom2, color: AppColor.primaryColor),
          SvgPicture.asset(selectedIndex.value == 5 ? AppSvg.clockSvgrepoCom : AppSvg.clockSvgrepoCom, color: AppColor.primaryColor),
        ]);
      }
    }

    // Ensure we have at least one page
    if (pages.isEmpty) {
      pages.addAll([const Order(), const ChekInTime()]);
      ledingPages.addAll([
        SvgPicture.asset(selectedIndex.value == 0 ? AppSvg.truckSvgrepoCom : AppSvg.truckTickSvgrepoCom2, color: AppColor.primaryColor),
        SvgPicture.asset(selectedIndex.value == 5 ? AppSvg.clockSvgrepoCom : AppSvg.clockSvgrepoCom, color: AppColor.primaryColor),
      ]);
    }
  }

  Future<bool> onpop() async {
    try {
      final result = await Get.defaultDialog<bool>(
        title: "Exit",
        middleText: "Are you sure you want to exit?",
        confirm: ElevatedButton(onPressed: () => Get.back(result: true), child: const Text("Yes")),
        cancel: ElevatedButton(onPressed: () => Get.back(result: false), child: const Text("No")),
        backgroundColor: Colors.white,
        radius: 10,
        titleStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        middleTextStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        barrierDismissible: false, // Prevent dismissal by tapping outside
      );

      // Return false if the dialog was dismissed without selection
      return result ?? false;
    } catch (e) {
      // Handle any potential errors and prevent app crash
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    try {
      // Check if AuthController is available
      if (Get.isRegistered<AuthController>()) {
        selectedEmployee = Get.find<AuthController>().selectedEmployee;
      } else {
        // If AuthController is not registered, try to get it from arguments
        selectedEmployee = Get.arguments as EmployeModel?;
      }

      // Ensure we have a valid employee before proceeding
      if (selectedEmployee != null) {
        showPageAcesse();
        Get.put(CategoryController());
        Get.put(ItemController());
      } else {
        // If no employee is available, redirect to auth
        Get.offAllNamed('/');
      }
    } catch (e) {
      print('Error in HomeScreenController onInit: $e');
      // If there's an error, redirect to auth
      Get.offAllNamed('/');
    }
  }
}



                  // GButton(
                  //   icon: Icons.category,
                  //   // text: 'Category',
                  //   textColor: AppColor.primaryColor,
                  //   textSize: 15,
                  //   activeBorder: Border.all(color: AppColor.primaryColor),
                  //   leading: SvgPicture.asset(
                  //     controller.selectedIndex.value == 1 ? AppSvg.widget2SvgrepoCom : AppSvg.widget2SvgrepoCom1,
                  //     color: AppColor.primaryColor,
                  //   ),
                  // ), // Example: Updated icon/text
                  // GButton(
                  //   icon: Icons.spatial_tracking,
                  //   // text: 'Orders',
                  //   textColor: AppColor.primaryColor,
                  //   textSize: 15,
                  //   activeBorder: Border.all(color: AppColor.primaryColor),
                  //   leading: SvgPicture.asset(
                  //     controller.selectedIndex.value == 2 ? AppSvg.chartSvgrepoCom1 : AppSvg.chartSvgrepoCom,
                  //     color: AppColor.primaryColor,
                  //   ),
                  // ), // Example: Updated icon/text
                  // GButton(
                  //   icon: Icons.person,
                  //   // text: 'Profile',
                  //   textColor: AppColor.primaryColor,
                  //   textSize: 15,
                  //   activeBorder: Border.all(color: AppColor.primaryColor),
                  //   leading: SvgPicture.asset(
                  //     controller.selectedIndex.value == 3 ? AppSvg.truckSvgrepoCom : AppSvg.truckTickSvgrepoCom2,
                  //     color: AppColor.primaryColor,
                  //   ),
                  // ), // Example: Updated icon/text
                  // GButton(
                  //   icon: Icons.person,
                  //   // text: 'Profile',
                  //   textColor: AppColor.primaryColor,
                  //   textSize: 15,
                  //   activeBorder: Border.all(color: AppColor.primaryColor),
                  //   leading: SvgPicture.asset(
                  //     controller.selectedIndex.value == 4 ? AppSvg.user2 : AppSvg.user,
                  //     color: AppColor.primaryColor,
                  //   ),
                  // ), // Example: U