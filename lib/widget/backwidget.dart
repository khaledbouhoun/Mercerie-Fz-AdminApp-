import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Backwidget extends StatelessWidget {
  final Color? color;
  const Backwidget({super.key, this.color = AppColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: SvgPicture.asset(height: 30, width: 30, AppSvg.l, color: color),
    );
  }
}
