import 'dart:io';
import 'dart:math';

import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/category_model.dart';

class CategoryController extends GetxController {
  Crud crud = Crud();
  Dialogfun dialog = Dialogfun();

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

  List<CategoriesModel> categoreis = [];

  var categories = <Category>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<String> getpath(File? image) async {
    String path = '';
    if (image != null) {
      var response = await crud.uploadImage(AppLink.imageupload, image, AppLink.categoryImagesFolder);
      if (response.statusCode == 200) {
        path = response.body['path'];
        print("Image path: $path");
      }
    }
    return path;
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    print("getCategories called");
    var response = await crud.get(AppLink.categories);
    if (response.statusCode == 200) {
      categoreis.clear();
      categoreis.addAll((response.body['data'] as List).map((e) => CategoriesModel.fromJson(e)).toList());
    } else if (response.statusCode == 404) {
      categoreis = [];
    } else {
      Get.snackbar("Error", "Failed to load categories");
    }
    isLoading.value = false;

    update();
  }

  Future<void> deleteCategories(CategoriesModel categoriesModel) async {
    if (categoriesModel.categoriesImage!.isNotEmpty) {
      var responseimg = await crud.post(AppLink.imagedelete, {
        'filename': '${AppLink.categoryImagesFolder}/${categoriesModel.categoriesImage!}',
      });
      print("$responseimg");
    }
    var response = await crud.delete("${AppLink.categories}/${categoriesModel.categoriesId}", {});

    if (response.statusCode == 201) {
      getCategories();
      Get.back();
      dialog.showSuccessSnack("Success", "Categories deleted successfully");
    } else {
      dialog.showErrorSnack("Error", "Failed to delete categories");
    }
  }
}
