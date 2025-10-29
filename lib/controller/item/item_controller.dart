import 'dart:io';
import 'dart:math';

import 'package:admin_ecommerce_app/controller/category/category_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/data/model/item_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemController extends GetxController {
  // ItemData itemData = ItemData(Get.find());
  final CategoryController categoryController = Get.find();

  Crud crud = Crud();
  Dialogfun dialog = Dialogfun();

  // Filter Variables
  int? selectedCategory;
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  bool showActiveOnly = false;
  bool showInactiveOnly = false;

  // ADD Variables

  final formstate = GlobalKey<FormState>();
  final categoriesName = TextEditingController();
  final categoriesNameArabic = TextEditingController();
  File? image;
  Random random = Random();
  final ImagePicker picker = ImagePicker();

  // EDIT Variables
  TextEditingController editCategoriesName = TextEditingController();
  TextEditingController editCategoriesNameArabic = TextEditingController();
  File? editImage;
  String editpath = '';

  List<ItemModel> items = [];
  List<ItemModel> itemsserch = [];

  List<CategoriesModel> categoreis = [];

  @override
  void onInit() async {
    super.onInit();
    await getitems();
    await getCategories();
  }

  Future<void> toggleProductActive(ItemModel item) async {
    if (item.itemsId == null) {
      return;
    }
    var response = await crud.get("${AppLink.itemsToggleStatus}/${item.itemsId}");
    if (response.statusCode == 200) {
      item.itemsActive = item.itemsActive == 1 ? 0 : 1; // Toggle the status
      update();
      dialog.showSuccessSnack("Success", "Product status updated successfully");
    } else {
      dialog.showErrorSnack("Error", "Failed to update product status");
    }
  }

  Future<void> getCategories() async {
    categoryController.getCategories();
    categoreis = categoryController.categoreis;
    update();
  }

  Future<void> getitems() async {
    try {
      var response = await crud.get(AppLink.items);
      if (response.statusCode == 200) {
        items.clear();
        itemsserch.clear();
        items.addAll((response.body['data'] as List).map((e) => ItemModel.fromJson(e)).toList());
        itemsserch.addAll(items);
      } else {
        items = [];
      }
    } catch (e) {
      print("Error fetching items: $e");
      dialog.showErrorSnack("Error", "Failed to load items");

      return;
    }
    update();
  }

  Future<bool> deleteItemImages(ItemModel item) async {
    bool success = true;
    try {
      if (item.images != null && item.images!.isNotEmpty) {
        for (String imageUrl in item.images!) {
          var response = await crud.post(AppLink.imagedelete, {"filename": "${AppLink.itemImagesFolder}/$imageUrl"});
          if (response.statusCode != 200) {
            success = false;
            break;
          } else {
            await CachedNetworkImage.evictFromCache(AppLink.itemImagesPath + imageUrl);
          }
        }
      }
    } catch (e) {
      print("Error deleting item images: $e");
      dialog.showErrorSnack("Error", "Failed to delete item images");
    }
    return success;
  }

  Future<void> deleteItem(ItemModel item) async {
    bool deleteImages = await deleteItemImages(item);
    if (!deleteImages) {
      dialog.showErrorSnack("Error", "Failed to delete item images");
      return;
    }
    var response = await crud.delete(AppLink.items, {"items_id": item.itemsId});
    if (response.statusCode == 201) {
      dialog.showSuccessSnack("Success", "Item deleted successfully");
      items.removeWhere((element) => element.itemsId == item.itemsId);
      itemsserch.removeWhere((element) => element.itemsId == item.itemsId);
    } else {
      dialog.showErrorSnack("Error", "Failed to delete item");
    }
  }

  Future<void> searchItems(String query) async {
    if (query.isEmpty) {
      await getitems();
    } else {
      itemsserch = items.where((item) => item.itemsNameFr!.toLowerCase().contains(query.toLowerCase())).toList();
      update();
    }
  }

  void filterByCategory(int? categoryId) {
    selectedCategory = categoryId;
    applyFilters();
  }

  void filterByStatus(bool active, bool inactive) {
    showActiveOnly = active;
    showInactiveOnly = inactive;
    applyFilters();
  }

  void resetFilters() {
    selectedCategory = null;
    minPriceController.clear();
    maxPriceController.clear();
    showActiveOnly = false;
    showInactiveOnly = false;
    itemsserch = List.from(items);
    update();
  }

  void applyFilters() {
    itemsserch =
        items.where((item) {
          // Category filter
          if (selectedCategory != null && item.itemsCat != selectedCategory) {
            return false;
          }

          // Price filter
          if (minPriceController.text.isNotEmpty) {
            double minPrice = double.tryParse(minPriceController.text) ?? 0;
            double itemPrice = item.itemsPrice ?? 0;
            if (itemPrice < minPrice) {
              return false;
            }
          }
          if (maxPriceController.text.isNotEmpty) {
            double maxPrice = double.tryParse(maxPriceController.text) ?? double.infinity;
            double itemPrice = item.itemsPrice ?? 0;
            if (itemPrice > maxPrice) {
              return false;
            }
          }

          // Status filter
          if (showActiveOnly && item.itemsActive != 1) {
            return false;
          }
          if (showInactiveOnly && item.itemsActive == 1) {
            return false;
          }

          return true;
        }).toList();

    update();
  }
}
