import 'dart:convert';
import 'dart:io';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/controller/item/item_controller.dart';
import 'package:admin_ecommerce_app/data/model/unite_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemAddController extends GetxController {
  Crud crud = Crud();
  Dialogfun dialog = Dialogfun();
  // ADD Variables

  final formstate = GlobalKey<FormState>();
  final itemName = TextEditingController();
  final itemNameArabic = TextEditingController();
  final itemDescription = TextEditingController();
  final itemDescriptionArabic = TextEditingController();
  final itemSize = TextEditingController();
  final itemLimite = TextEditingController();
  final itemPrice = TextEditingController();
  UniteModel? selectedUnite;
  List<UniteModel> unites = [];
  CategoriesModel? selectedCategory;
  List<CategoriesModel> categories = [];

  // File? image;
  List<File> images = [];

  final ImagePicker picker = ImagePicker();

  // Get color form image
  Color color = Colors.red;
  bool vis1 = false;
  bool vis2 = false;
  Offset? tapPosition;

  // add color
  File? image2;
  Color? selectedColor;
  List<Color> listColor = [];
  List<String> colorsString = [];

  RxBool isLoading = false.obs;
  RxBool categoryselctederoor = false.obs;
  RxBool colorselctederoor = false.obs;

  @override
  void onInit() {
    super.onInit();
    getunites();
    categories = Get.arguments['listcategories'];
  }

  void colortostring() {
    colorsString.clear();
    for (int i = 0; i < listColor.length; i++) {
      String colorString = listColor[i].value.toRadixString(16);
      colorsString.add(colorString);
    }
    print('colorstring $colorsString');
    print('listcolor ${listColor.length}');

    update();
  }

  Color stringtocolor(String colorString) {
    return Color(int.parse(colorString, radix: 16));
  }

  void addcolor(Color color) {
    if (!listColor.contains(color)) {
      listColor.add(color);
      colortostring();
    }
    update();
  }

  Future<List<String>> uploadImages() async {
    List<String> imagePaths = [];
    try {
      if (images.isNotEmpty) {
        for (File file in images) {
          var response = await crud.uploadImage(AppLink.imageupload, file, AppLink.itemImagesFolder);
          imagePaths.add(response.body['filename']);
        }
      }
    } catch (e) {
      print("Error deleting item images: $e");
      dialog.showErrorSnack("Error", "Failed to delete item images");
    }
    return imagePaths;
  }

  Future<void> getunites() async {
    try {
      final response = await crud.get(AppLink.unites);
      if (response.statusCode == 200) {
        List data = response.body['data'];
        unites = data.map((e) => UniteModel.fromJson(e)).toList();
        update();
      }
    } catch (e) {
      print("Error fetching unites: $e");
      dialog.showErrorSnack("Error", "Failed to fetch unites");
    }
  }

  Future<void> additemes() async {
    try {
      if (formstate.currentState == null || !formstate.currentState!.validate()) {
        dialog.showErrorSnack("Error", "Please fill all required fields");
        return;
      }
      if (selectedCategory == null) {
        dialog.showErrorSnack("Error", "Please select a category");

        categoryselctederoor.value = true;
        return;
      }
      if (unites.isNotEmpty && selectedUnite == null) {
        dialog.showErrorSnack("Error", "Please select a unite");
        return;
      }
      if (colorsString.isEmpty) {
        dialog.showErrorSnack("Error", "Please select at least one color");
        colorselctederoor.value = true;
        return;
      }
      isLoading.value = true;

      colortostring();
      List<String> imagePaths = [];
      if (images.isNotEmpty) {
        imagePaths = await uploadImages();
      }

      final data = {
        "items_name_fr": itemName.text,
        "items_name_ar": itemNameArabic.text,
        "items_desc_fr": itemDescription.text,
        "items_desc_ar": itemDescriptionArabic.text,
        "items_size": itemSize.text,
        "items_unite": selectedUnite!.uniteId,
        "items_limite": itemLimite.text,
        "items_price": itemPrice.text,
        "items_cat": selectedCategory!.categoriesId,
        "items_images": imagePaths,
        "listcolor": colorsString,
      };
      print(data);
      print(" with decode : ${jsonEncode(data)}");
      final response = await crud.post(AppLink.items, data);
      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.back();
        dialog.showSuccessSnack("Success", "Product added successfully");
        await Get.find<ItemController>().getitems();
      }
    } catch (e) {
      dialog.showErrorSnack("Error", "Failed to add product");
      isLoading.value = false;
      print(e);
    } finally {
      isLoading.value = false;
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
