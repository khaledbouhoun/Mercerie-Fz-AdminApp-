import 'dart:io';
import 'dart:math';

import 'package:admin_ecommerce_app/controller/category/category_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryAddController extends GetxController {
  Crud crud = Crud();
  Dialogfun dialog = Dialogfun();
  CategoryController categoryController = Get.find<CategoryController>();

  // ADD Variables

  final formstate = GlobalKey<FormState>();
  final categoriesName = TextEditingController();
  final categoriesNameArabic = TextEditingController();
  RxBool isLoading = false.obs;
  File? image;
  Random random = Random();
  final ImagePicker picker = ImagePicker();

  Future<String> getpath(File? image) async {
    String path = '';
    if (image != null) {
      var response = await crud.uploadImage(AppLink.imageupload, image, AppLink.categoryImagesFolder);
      if (response.statusCode == 201) {
        print("---------------------");
        print(response.body);
        print("---------------------");
        path = response.body['filename'];
        print("Image path: $path");
      }
    }
    return path;
  }

  Future<void> addCategories() async {
    if (formstate.currentState!.validate()) {
      isLoading.value = true;

      String imagePath = await getpath(image);
      Map<String, dynamic> data = {
        "categories_name": categoriesName.text,
        "categories_nama_ar": categoriesNameArabic.text,
        "categories_image": imagePath,
      };
      print(data);
      var response = await crud.post(AppLink.categories, data);
      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.back();
        dialog.showSuccessSnack("Success", "Categories added successfully");
        categoriesName.clear();
        categoriesNameArabic.clear();
        image = null;
        await categoryController.getCategories();
      } else {
        isLoading.value = false;
        dialog.showErrorSnack("Error", "Failed to add categories");
      }
    } else {
      dialog.showErrorSnack("Error", "Please fill all fields correctly");
    }
  }

  Future<File?> pickImageFromCamera() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      update();
      return File(pickedFile.path);
    }
    update();
    return null;
  }
}
