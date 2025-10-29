import 'package:admin_ecommerce_app/core/constant/color.dart';
import 'package:admin_ecommerce_app/core/constant/imageasset.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Categorywidget extends StatelessWidget {
  final CategoriesModel categoriesModel;
  final VoidCallback? onedit;
  final VoidCallback? ondelete;
  const Categorywidget({super.key, required this.categoriesModel, this.onedit, this.ondelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 180,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryColor),
      ),
      child: Row(
        children: [
          // Left side - Content
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoriesModel.categoriesName!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onedit,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppSvg.edit3SvgrepoCom, color: AppColor.white, width: 20, height: 20),
                          SizedBox(width: 8),
                          Text('edit', style: TextStyle(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: ondelete,
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppSvg.trashBinTrashSvgrepoCom, color: AppColor.white, width: 20, height: 20),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Right side - Image
          Expanded(
            flex: 1,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: AppColor.background,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child:
                    categoriesModel.categoriesImage != null && categoriesModel.categoriesImage!.isNotEmpty
                        ? CachedNetworkImage(
                          imageUrl: AppLink.categoryImagesPath + categoriesModel.categoriesImage!,
                          fit: BoxFit.scaleDown,
                          errorWidget:
                              (context, url, error) => Padding(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor),
                              ),
                          placeholder: (context, url) => const Center(child: SizedBox()),
                        )
                        : Container(
                          color: AppColor.background,
                          padding: const EdgeInsets.all(25),
                          child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
