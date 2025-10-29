import 'package:admin_ecommerce_app/controller/order/cash_controller.dart';
import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/cartcolor_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomItemsCartList extends StatelessWidget {
  final bool iscompleted;
  final Color colorshop;
  final int id;
  final int idcart;
  final String name;
  final double price;
  final double count;
  final String size;
  final String imagename;
  final bool isChecked;
  final List<Clr> clr;

  final void Function(bool?)? onChanged;
  final void Function()? onPressed;
  final void Function()? onRemove;
  const CustomItemsCartList({
    super.key,
    required this.colorshop,
    required this.iscompleted,
    required this.id,
    required this.idcart,
    required this.name,
    required this.price,
    required this.count,
    required this.size,
    required this.imagename,
    required this.onRemove,
    required this.isChecked,
    required this.clr,

    this.onChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: colorshop.withOpacity(0.2), blurRadius: 10, offset: const Offset(2, 2))],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isChecked ? Border.all(color: colorshop, width: 1.5) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product Image or Placeholder
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  imagename.isNotEmpty
                      ? Image.network(
                        imagename,
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, width: 20, height: 20, color: colorshop.withOpacity(0.15)),
                      )
                      : SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, width: 20, height: 20, color: colorshop.withOpacity(0.15)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: colorshop),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: colorshop.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                      child: Text('x$count', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colorshop)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(AppSvg.rulerAngularSvgrepoCom, width: 18, height: 18, color: colorshop),
                    const SizedBox(width: 4),
                    Text(size, style: const TextStyle(fontSize: 15, color: AppColor.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(AppSvg.paletteSvgrepoCom, width: 18, height: 18, color: colorshop),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        if (clr.isNotEmpty) {
                          Get.defaultDialog(
                            title: "Colors & Quantities",
                            content: SizedBox(
                              height: clr.length * 48.0,
                              width: Get.width * 0.5,
                              child: ListView.builder(
                                itemCount: clr.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 6),
                                        height: 32,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: clr[index].color ?? colorshop,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300, width: 1),
                                        ),
                                      ),
                                      Text(
                                        "x ${clr[index].qty}",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorshop, fontFamily: 'Roboto'),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 18,
                        child:
                            clr.isNotEmpty
                                ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: clr.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 18,
                                      height: 18,
                                      margin: const EdgeInsets.only(right: 4),
                                      decoration: BoxDecoration(
                                        color: clr[index].color ?? colorshop,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey.shade300, width: 1),
                                      ),
                                    );
                                  },
                                )
                                : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('$price DA', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorshop))],
                ),
              ],
            ),
          ),
          if (!iscompleted)
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: onChanged,
                    activeColor: colorshop,
                    hoverColor: colorshop,
                    overlayColor: WidgetStateProperty.all(colorshop),
                    focusColor: colorshop,
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.all(isChecked ? colorshop : AppColor.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  IconButton(
                    onPressed: onRemove,
                    icon: SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, width: 25, height: 25, color: AppColor.warning),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CustomItemsCartListYallidine extends StatelessWidget {
  final bool iscompleted;
  final int id;
  final int idcart;
  final String name;
  final double price;
  final double count;
  final String size;
  final String imagename;
  final bool isChecked;
  final List<Clr> clr;

  final void Function(bool?)? onChanged;
  final void Function()? onPressed;
  final void Function()? onRemove;
  const CustomItemsCartListYallidine({
    super.key,
    required this.iscompleted,
    required this.id,
    required this.idcart,
    required this.name,
    required this.price,
    required this.count,
    required this.size,
    required this.imagename,
    required this.onRemove,
    required this.isChecked,
    required this.clr,

    this.onChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: AppColor.yallidineColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(2, 2))],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isChecked ? Border.all(color: AppColor.yallidineColor, width: 1.5) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product Image or Placeholder
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),

              child: CachedNetworkImage(
                imageUrl: imagename,
                width: 90,
                height: 120,
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) => SvgPicture.asset(
                      AppSvg.galleryRemoveSvgrepoCom,
                      width: 20,
                      height: 20,
                      color: AppColor.yallidineColor.withOpacity(0.15),
                    ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: AppColor.yallidineColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColor.yallidineColor.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'x$count',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColor.yallidineColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(AppSvg.rulerAngularSvgrepoCom, width: 18, height: 18, color: AppColor.yallidineColor),
                    const SizedBox(width: 4),
                    Text(size, style: const TextStyle(fontSize: 15, color: AppColor.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(AppSvg.paletteSvgrepoCom, width: 18, height: 18, color: AppColor.yallidineColor),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: "Colors & Quantities",
                          content: SizedBox(
                            height: clr.length * 48.0,
                            width: Get.width * 0.5,
                            child: ListView.builder(
                              itemCount: clr.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      height: 32,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: clr[index].color ?? AppColor.yallidineColor,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade300, width: 1),
                                      ),
                                    ),
                                    Text(
                                      "x ${clr[index].qty}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.yallidineColor,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 18,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // itemCount: 1,
                          itemCount: clr.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 18,
                              height: 18,
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                color: clr[index].color ?? AppColor.yallidineColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey.shade300, width: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$price DA', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColor.yallidineColor)),
                    // Checkbox(value: isChecked, onChanged: iscompleted ? null : onChanged, activeColor: AppColor.yallidineColor),
                    // if (onRemove != null && !iscompleted)
                    //   IconButton(icon: const Icon(Icons.delete, color: AppColor.warning), onPressed: onRemove),
                  ],
                ),
              ],
            ),
          ),
          if (!iscompleted)
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: onChanged,
                    activeColor: AppColor.yallidineColor,
                    hoverColor: AppColor.yallidineColor,
                    overlayColor: WidgetStateProperty.all(AppColor.yallidineColor),
                    focusColor: AppColor.yallidineColor,
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.all(isChecked ? AppColor.yallidineColor : AppColor.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  IconButton(
                    onPressed: onRemove,
                    icon: SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, width: 25, height: 25, color: AppColor.warning),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
