import 'package:admin_ecommerce_app/controller/order/orderDetails_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/customitemscartlist.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Orderdetails extends StatelessWidget {
  const Orderdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      builder: (controller) {
        final bool isCompleted = controller.iscompleted ?? false;
        final bool isHistory = controller.history ?? false;
        return Scaffold(
          backgroundColor: AppColor.background,
          appBar: AppBar(
            backgroundColor: controller.colorshop,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: const Text('Order Cash Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white)),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColor.white),
              onPressed: () async {
                if (!isCompleted) {
                  await controller.onpop2();
                } else {
                  Get.back();
                }
              },
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (!isCompleted) {
                print('---onwillpop');
                return await controller.onpop();
              } else {
                print('---onwillpop8888');
                return true;
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        height: 210,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: controller.colorshop,
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white.withOpacity(0.18),
                                  child: SvgPicture.asset(AppSvg.ticket, width: 40, height: 40, color: AppColor.white),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${controller.cashselcted?.ordersId ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.white,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppSvg.calendarDateSvgrepoCom, width: 25, height: 25, color: Colors.white),
                                        const SizedBox(width: 10),
                                        Text(
                                          controller.cashselcted?.ordersDatetime != null
                                              ? controller.cashselcted!.ordersDatetime!.toLocal().toString().split(' ')[0]
                                              : 'N/A',
                                          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white.withOpacity(0.13),
                                  child: SvgPicture.asset(AppSvg.user2, width: 20, height: 20, color: AppColor.white),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  controller.cashselcted?.usersName ?? '-',
                                  style: const TextStyle(fontSize: 18, color: AppColor.white, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white.withOpacity(0.13),
                                      child: SvgPicture.asset(AppSvg.phoneSvgrepoCom, width: 20, height: 20, color: AppColor.white),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      controller.cashselcted?.usersPhone ?? '-',
                                      style: const TextStyle(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isCompleted ? Colors.green.withOpacity(0.18) : controller.colorshop.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: isCompleted ? Colors.green : controller.colorshop, width: 1.8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (isCompleted ? Colors.green : controller.colorshop).withOpacity(0.12),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isCompleted ? Icons.check_circle : Icons.timelapse,
                                        color: isCompleted ? Colors.green : controller.colorshop,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        isCompleted ? 'Completed' : 'Pending',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: isCompleted ? Colors.green : controller.colorshop,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Info Card
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: controller.colorshop.withOpacity(0.10),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(2, 2),
                              ),
                            ],
                            border: Border.all(color: controller.colorshop.withOpacity(0.08), width: 1.2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.attach_money, color: controller.colorshop, size: 25),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Total Price:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: controller.colorshop,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${controller.cashselcted?.ordersTotalprice ?? 0} DA',
                                      style: const TextStyle(fontSize: 18, color: AppColor.black, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppSvg.loction, width: 25, height: 25, color: controller.colorshop),
                                    const SizedBox(width: 10),
                                    Text('Shop:', style: TextStyle(fontSize: 16, color: controller.colorshop, fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 6),
                                    Text(
                                      controller.cashselcted?.shop == 1 ? 'Bachdjerrah' : 'Belcourt',
                                      style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    SvgPicture.asset(AppSvg.widget2SvgrepoCom1, width: 25, height: 25, color: controller.colorshop),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Items:',
                                      style: TextStyle(fontSize: 16, color: controller.colorshop, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${controller.cashselcted?.items ?? 0}',
                                      style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Select All Checkbox
                      if (!isCompleted)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: controller.colorshop.withOpacity(0.2), blurRadius: 10, offset: const Offset(2, 2)),
                            ],
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: controller.isChecked.every((element) => element) ? controller.colorshop : AppColor.white,
                              width: 1,
                            ),
                          ),
                          child: CheckboxListTile(
                            value: controller.isChecked.every((element) => element),
                            checkColor: Colors.white,
                            activeColor: controller.colorshop,
                            side: BorderSide(color: controller.colorshop, width: 1),
                            contentPadding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: controller.colorshop, width: 1),
                            ),
                            onChanged: (value) {
                              for (int i = 0; i < controller.isChecked.length; i++) {
                                controller.isChecked[i] = value ?? false;
                              }
                              controller.update();
                            },
                            title: const Text('Select All'),
                          ),
                        ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final cart = controller.carts[index];
                      return CustomItemsCartList(
                        colorshop: controller.colorshop,
                        iscompleted: controller.iscompleted ?? false,
                        onPressed: () {},
                        onChanged: (value) {
                          controller.isChecked[index] = value ?? false;
                          controller.update();
                        },
                        onRemove: () async {
                          Get.defaultDialog(
                            title: "Delete Item",
                            middleText: "Are you sure you want to delete this item from the order?",
                            textConfirm: "Yes",
                            textCancel: "No",
                            confirmTextColor: Colors.white,
                            cancelTextColor: controller.colorshop,
                            buttonColor: controller.colorshop,
                            onConfirm: () async {
                              Get.back();
                              await controller.cashDeleteItemCart(cart.prdId?.toString() ?? "");
                            },
                            onCancel: () {},
                          );
                        },
                        imagename: AppLink.itemImagesPath + (cart.itemsImage ?? ""),
                        id: cart.itemsId!,
                        idcart: cart.prdId!,
                        name: cart.itemsNameFr!,
                        size: cart.itemsSize!,
                        price: cart.itemspricetotal!,
                        count: cart.countitems!,
                        isChecked: controller.isChecked[index],
                        clr: cart.clr ?? [],
                      );
                    }, childCount: controller.carts.length),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () async {
                    final phone = controller.cashselcted?.usersPhone;
                    if (phone != null && phone.isNotEmpty) {
                      await launchUrl(Uri.parse('tel:$phone'), mode: LaunchMode.externalApplication);
                    }
                  },
                  backgroundColor: const Color.fromARGB(255, 23, 156, 0),
                  child: const Icon(Icons.call, color: Colors.white),
                ),
                if (!isHistory)
                  if (!isCompleted)
                    FloatingActionButton.extended(
                      heroTag: 'btn2',
                      isExtended: true,
                      onPressed: () {
                        if (controller.isChecked.every((element) => element)) {
                          controller.confirmOrder();
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please select all items to confirm the order.',
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(10),
                          );
                        }
                      },
                      backgroundColor: controller.colorshop,
                      label: const SizedBox(
                        width: 200,
                        child: Text('Confirm Order', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    )
                  else if (isCompleted)
                    FloatingActionButton.extended(
                      heroTag: 'btn3',
                      isExtended: true,
                      onPressed: () {
                        controller.confirmOrderComplete();
                      },
                      backgroundColor: Colors.green,
                      label: const SizedBox(
                        width: 200,
                        child: Text('Order Completed', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    )
                  else
                    FloatingActionButton.extended(
                      heroTag: 'btn4',
                      isExtended: true,
                      onPressed: () {},
                      backgroundColor: AppColor.grey,
                      label: const SizedBox(
                        width: 200,
                        child: Text(
                          'This Order is Completed',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
