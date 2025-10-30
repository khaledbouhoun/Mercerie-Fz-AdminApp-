import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/item_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Itemwidget extends StatelessWidget {
  final ItemModel itemModel;
  final VoidCallback? onedit;
  final VoidCallback? onActivate;
  final VoidCallback? ondelete;
  const Itemwidget({super.key, required this.itemModel, this.onedit, this.ondelete, this.onActivate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.background.withOpacity(0.2)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  (itemModel.images != null && itemModel.images!.isNotEmpty)
                      ? CachedNetworkImage(
                        imageUrl: AppLink.itemImagesPath + itemModel.images!.first,
                        fit: BoxFit.cover,
                        errorWidget:
                            (context, url, error) => Center(
                              child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor.withOpacity(0.5)),
                            ),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      )
                      : Center(child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor.withOpacity(0.5))),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemModel.itemsNameFr ?? 'No Name',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.black, letterSpacing: 0.2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    InkWell(
                      onTap: onActivate,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: (itemModel.itemsActive == 1) ? Colors.green.withOpacity(0.12) : Colors.red.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: (itemModel.itemsActive == 1) ? Colors.green : Colors.red, width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              itemModel.itemsActive == 1 ? Icons.check_circle : Icons.cancel,
                              color: (itemModel.itemsActive == 1) ? Colors.green : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              (itemModel.itemsActive == 1) ? 'Active' : 'Inactive',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: (itemModel.itemsActive == 1) ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: onedit,
                            icon: SvgPicture.asset(AppSvg.edit3SvgrepoCom, color: AppColor.primaryColor, width: 22, height: 22),
                            tooltip: 'Edit',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: ondelete,
                            icon: SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, color: Colors.red, width: 22, height: 22),
                            tooltip: 'Delete',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
