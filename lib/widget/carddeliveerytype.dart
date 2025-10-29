import 'package:flutter/material.dart';

class CardDeliveryTypeCheckout extends StatelessWidget {
  final Function()? onTap;
  final String imagename;
  final int d;

  const CardDeliveryTypeCheckout({super.key, required this.imagename, required this.onTap, required this.d});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: Get.height * 0.3,
        height: 250,
        width: 350,
        // width: Get.width,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: d == 1 ? Color.fromARGB(255, 214, 46, 46) : Color.fromARGB(255, 53, 112, 6)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: d == 1 ? Color.fromARGB(255, 214, 46, 46).withOpacity(0.5) : Color.fromARGB(255, 53, 112, 6).withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          image: DecorationImage(image: AssetImage(imagename), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
