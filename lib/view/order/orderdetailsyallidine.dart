import 'package:admin_ecommerce_app/controller/order/orderDetailsYallidne_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/customitemscartlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderdetailsYallidine extends StatelessWidget {
  const OrderdetailsYallidine({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsYallidineController controller = Get.put(OrderDetailsYallidineController());
    final bool isCompleted = controller.iscompleted ?? false;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.yallidineColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Order Yallidine Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () async {
            if (controller.iscompleted == false) {
              var res = await controller.onpop();
              if (res) {
                Get.back();
              }
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: GetBuilder<OrderDetailsYallidineController>(
        init: OrderDetailsYallidineController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (!isCompleted) {
                return await controller.onpop();
              } else {
                return true;
              }
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    height: 210,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColor.yallidineColor,
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
                                  'Order #${controller.yallidineselcted?.yId ?? ''}',
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
                                      controller.yallidineselcted?.yDatetime != null
                                          ? controller.yallidineselcted!.yDatetime!.toLocal().toString().split(' ')[0]
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
                              '${controller.yallidineselcted?.yName ?? '-'} ${controller.yallidineselcted?.yPrenome ?? ''}',
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
                                  controller.yallidineselcted?.yTel ?? '-',
                                  style: const TextStyle(fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: isCompleted ? Colors.green.withOpacity(0.18) : AppColor.yallidineColor.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: isCompleted ? Colors.green : AppColor.yallidineColor, width: 1.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isCompleted ? Colors.green : AppColor.yallidineColor).withOpacity(0.12),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isCompleted ? Icons.check_circle : Icons.timelapse,
                                    color: isCompleted ? Colors.green : AppColor.yallidineColor,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    isCompleted ? 'Completed' : 'Pending',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: isCompleted ? Colors.green : AppColor.yallidineColor,
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
                            color: AppColor.yallidineColor.withOpacity(0.10),
                            spreadRadius: 4,
                            blurRadius: 10,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        border: Border.all(color: AppColor.yallidineColor.withOpacity(0.08), width: 1.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.attach_money, color: AppColor.yallidineColor, size: 25),
                                const SizedBox(width: 10),
                                Text(
                                  'Total Price:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.yallidineColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${controller.yallidineselcted?.yTotalprice ?? 0} DA',
                                  style: const TextStyle(fontSize: 18, color: AppColor.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(AppSvg.citySvgrepoCom, width: 25, height: 25, color: AppColor.yallidineColor),
                                const SizedBox(width: 10),
                                Text(
                                  'Wilaya:',
                                  style: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  controller.yallidineselcted?.yWilaya ?? '-',
                                  style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(AppSvg.loction, width: 25, height: 25, color: AppColor.yallidineColor),
                                const SizedBox(width: 10),
                                Text(
                                  'Commune:',
                                  style: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  controller.yallidineselcted?.yComunue ?? '-',
                                  style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(AppSvg.truckTickSvgrepoCom2, width: 25, height: 25, color: AppColor.yallidineColor),
                                const SizedBox(width: 10),
                                Text(
                                  'Delivery Type:',
                                  style: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  controller.yallidineselcted?.yDelvreytype == 1 ? 'Center' : 'Home',
                                  style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(AppSvg.widget2SvgrepoCom1, width: 25, height: 25, color: AppColor.yallidineColor),
                                const SizedBox(width: 10),
                                Text('Items:', style: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 6),
                                Text(
                                  '${controller.yallidineselcted?.items ?? 0}',
                                  style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (!isCompleted)
                              Row(
                                children: [
                                  SvgPicture.asset(AppSvg.weightSvgrepoCom, width: 25, height: 25, color: AppColor.yallidineColor),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: controller.weight,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      textInputAction: TextInputAction.done,
                                      onTapUpOutside: (event) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Enter Weight (kg)',
                                        hintText: '0.0',
                                        labelStyle: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600),

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: AppColor.yallidineColor, width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: AppColor.yallidineColor, width: 1),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: AppColor.grey, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(color: AppColor.yallidineColor, width: 2),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  SvgPicture.asset(AppSvg.weightSvgrepoCom, width: 25, height: 25, color: AppColor.yallidineColor),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Weight:',
                                    style: TextStyle(fontSize: 16, color: AppColor.yallidineColor, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${controller.yallidineselcted?.yWeight ?? 0} kg',
                                    style: const TextStyle(fontSize: 17, color: AppColor.black, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
                          BoxShadow(color: AppColor.yallidineColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(02, 2)),
                        ],
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.isChecked.every((element) => element) ? AppColor.yallidineColor : AppColor.white,
                          width: 1,
                        ),
                      ),
                      child: CheckboxListTile(
                        value: controller.isChecked.every((element) => element),
                        checkColor: Colors.white,
                        activeColor: AppColor.yallidineColor,
                        side: BorderSide(color: AppColor.yallidineColor, width: 1),
                        contentPadding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: AppColor.yallidineColor, width: 1),
                        ),
                        onChanged: (value) {
                          for (int i = 0; i < controller.isChecked.length; i++) {
                            controller.isChecked[i] = value!;
                          }
                          controller.update();
                        },
                        title: const Text('Select All'),
                      ),
                    ),
                  // Order Items List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.carts.length,
                      itemBuilder: (context, index) {
                        return CustomItemsCartListYallidine(
                          iscompleted: controller.iscompleted!,
                          onPressed: () {},
                          onChanged: (value) {
                            controller.isChecked[index] = value!;
                            controller.update();
                          },
                          onRemove: () async {
                            Get.defaultDialog(
                              title: "",
                              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                              middleText: "",
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, width: 50, height: 50, color: AppColor.yallidineColor),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Are you sure you want to remove this item from the order?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.yallidineColor),
                                  ),
                                ],
                              ),
                              textConfirm: "Delete",
                              textCancel: "Cancel",
                              radius: 12,
                              backgroundColor: Colors.white,
                              barrierDismissible: false,
                              confirmTextColor: Colors.white,
                              cancelTextColor: AppColor.yallidineColor,
                              buttonColor: Colors.redAccent,

                              onConfirm: () async {
                                Get.back();
                                await controller.yallidineDeleteItemCart(controller.carts[index].prdId.toString());
                              },
                              onCancel: () {},
                            );
                          },
                          imagename:
                              controller.carts[index].itemsImage != null
                                  ? AppLink.itemImagesPath + controller.carts[index].itemsImage!
                                  : "",
                          id: controller.carts[index].itemsId!,
                          idcart: controller.carts[index].prdId!,
                          name: controller.carts[index].itemsNameFr!,
                          size: controller.carts[index].itemsSize!,
                          price: controller.carts[index].itemspricetotal!,
                          count: controller.carts[index].countitems!,
                          isChecked: controller.isChecked[index],
                          clr: controller.carts[index].clr!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'btn1',
              onPressed: () async {
                launchUrl(Uri.parse('tel:${controller.yallidineselcted?.yTel}'), mode: LaunchMode.externalApplication);
              },
              backgroundColor: AppColor.yallidineColor,
              child: const Icon(Icons.call, color: Colors.white),
            ),
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
                      'Please select all items to confirm the order',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: AppColor.yallidineColor.withOpacity(0.8),
                      colorText: Colors.white,
                    );
                  }
                },
                backgroundColor: AppColor.yallidineColor,
                label: const SizedBox(
                  width: 200,
                  child: Text('Confirm Order', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            else
              FloatingActionButton.extended(
                heroTag: 'btn3',
                isExtended: true,
                onPressed: () {
                  controller.createParcels(controller.yallidineselcted!);
                },
                backgroundColor: AppColor.yallidineColor,
                label: const SizedBox(
                  width: 200,
                  child: Text('Create Parcel', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
