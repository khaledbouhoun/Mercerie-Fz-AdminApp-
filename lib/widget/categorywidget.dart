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

  Widget _buildActionButton({required VoidCallback? onTap, required String icon, required String label, required Color color}) {
    return Expanded(
      child: Material(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon, color: color, width: 18, height: 18),
                const SizedBox(width: 6),
                Text(label, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColor.background.withOpacity(0.1),
      padding: const EdgeInsets.all(25),
      child: SvgPicture.asset(AppSvg.galleryRemoveSvgrepoCom, color: AppColor.primaryColor.withOpacity(0.5)),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(color: AppColor.background.withOpacity(0.1), child: const Center(child: CircularProgressIndicator(strokeWidth: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.2), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Row(
          children: [
            // Left side - Image
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(color: AppColor.background.withOpacity(0.1)),
                child:
                    categoriesModel.categoriesImage != null && categoriesModel.categoriesImage!.isNotEmpty
                        ? Hero(
                          tag: 'category_${categoriesModel.categoriesId}',
                          child: CachedNetworkImage(
                            imageUrl: AppLink.categoryImagesPath + categoriesModel.categoriesImage!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            errorWidget: (context, url, error) => _buildPlaceholder(),
                            placeholder: (context, url) => _buildLoadingPlaceholder(),
                          ),
                        )
                        : _buildPlaceholder(),
              ),
            ),

            // Right side - Content
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Name
                    Text(
                      categoriesModel.categoriesName!,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        _buildActionButton(onTap: onedit, icon: AppSvg.edit3SvgrepoCom, label: 'Edit', color: AppColor.primaryColor),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          onTap: ondelete,
                          icon: AppSvg.trashBinTrashSvgrepoCom,
                          label: 'Delete',
                          color: Colors.red.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
