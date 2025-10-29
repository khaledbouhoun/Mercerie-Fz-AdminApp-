import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/item_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class Itemwidget extends StatelessWidget {
  final ItemModel itemModel;
  final VoidCallback? onedit;
  final VoidCallback? onActivate;
  final VoidCallback? ondelete;
  const Itemwidget({super.key, required this.itemModel, this.onedit, this.ondelete, this.onActivate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColor.background),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  (itemModel.images != null && itemModel.images!.isNotEmpty)
                      ? CachedNetworkImage(
                        imageUrl: AppLink.itemImagesPath + itemModel.images!.first,
                        fit: BoxFit.scaleDown,
                        errorWidget:
                            (context, url, error) => Padding(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor),
                            ),
                        placeholder: (context, url) => const Center(child: SizedBox()),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor),
                      ),
            ),
          ),
          const SizedBox(width: 16),

          // Product Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemModel.itemsNameFr ?? 'No Name',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(width: 16),

              SizedBox(
                width: Get.width - 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status
                    InkWell(
                      onTap: onActivate,
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (itemModel.itemsActive == 1) ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: (itemModel.itemsActive == 1) ? Colors.green : Colors.red, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          (itemModel.itemsActive == 1) ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: (itemModel.itemsActive == 1) ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: onedit,
                          icon: SvgPicture.asset(
                            AppSvg.edit3SvgrepoCom,
                            color: const Color.fromARGB(255, 5, 130, 233),
                            width: 20,
                            height: 20,
                          ),
                          tooltip: 'Edit',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: ondelete,
                          icon: SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, color: Colors.red, width: 20, height: 20),
                          tooltip: 'Delete',
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildStatusCard(bool isActive) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColor.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.toggle_on_outlined, color: AppColor.primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Employee Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColor.black)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isActive ? Colors.green : Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: (isActive ? Colors.green : Colors.red).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isActive ? 'Active' : 'Inactive',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isActive ? Colors.green : Colors.red),
                    ),
                    Text(
                      isActive ? 'Employee is currently active' : 'Employee is currently inactive',
                      style: TextStyle(fontSize: 14, color: AppColor.grey),
                    ),
                  ],
                ),
                Switch(
                  value: isActive,
                  activeThumbColor: Colors.green,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
