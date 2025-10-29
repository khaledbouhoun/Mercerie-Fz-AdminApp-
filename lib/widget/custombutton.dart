import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final RxBool isLoading;
  final void Function()? onPressed;
  const CustomButtom({super.key, required this.text, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),

          onPressed: onPressed,

          child:
              isLoading.value
                  ? Center(child: const CircularProgressIndicator(color: Colors.white))
                  : Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }
}

class CustomButtomwith extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButtomwith({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: Colors.white,
        textColor: AppColor.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SvgPicture.asset(
            //   "assets/svg/$text.svg",
            //   width: 30,
            //   height: 30,
            // ),
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
