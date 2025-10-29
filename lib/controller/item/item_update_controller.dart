// import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:admin_ecommerce_app/controller/item/item_controller.dart';
import 'package:admin_ecommerce_app/core/class/crud.dart';
import 'package:admin_ecommerce_app/data/model/categoresis_model.dart';
import 'package:admin_ecommerce_app/data/model/item_model.dart';
import 'package:admin_ecommerce_app/data/model/unite_model.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:admin_ecommerce_app/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemUpdateController extends GetxController {
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

  ItemModel? itemModel;

  CategoriesModel? selectedCategory;
  List<CategoriesModel> categories = [];

  // List<File> images = [];
  List<String> imagesString = [];
  List<dynamic> allimages = [];
  Random random = Random();
  final ImagePicker picker = ImagePicker();

  // Get color form image
  Color color = Colors.red;
  Offset? tapPosition;

  // colros var
  File? image2;
  Color? selectedColor;
  bool vis1 = false;
  bool vis2 = false;
  RxBool colorselctederoor = false.obs;
  RxBool isLoading = false.obs;
  RxBool categoryselctederoor = false.obs;

  List<Color> listColor = [];
  List<Color> oldlistColor = [];
  List<String> colorsStringadd = [];
  List<String> colorsStringdelete = [];

  @override
  void onInit() async {
    super.onInit();
    categories = Get.arguments['listcategories'];
    itemModel = Get.arguments['itemModel'];
    if (itemModel!.itemsCat != null) {
      selectedCategory = categories.firstWhere((category) => category.categoriesId == itemModel!.itemsCat);
    } else {
      selectedCategory = null;
    }
    itemName.text = itemModel!.itemsNameFr ?? '';
    itemNameArabic.text = itemModel!.itemsNameAr ?? '';
    itemDescription.text = itemModel!.itemsDescFr ?? '';
    itemDescriptionArabic.text = itemModel!.itemsDescAr ?? '';
    itemSize.text = itemModel!.itemsSize ?? '';
    itemLimite.text = itemModel!.itemsLimite?.toString() ?? '';
    itemPrice.text = itemModel!.itemsPrice?.toString() ?? '';
    imagesString = itemModel!.images ?? [];
    allimages.addAll(imagesString);

    await getunites();

    await getcolor(itemModel!.itemsId.toString());
  }

  Future<void> getunites() async {
    try {
      final response = await crud.get(AppLink.unites);
      if (response.statusCode == 200) {
        List data = response.body['data'];
        unites = data.map((e) => UniteModel.fromJson(e)).toList();
        print(unites.first.uniteNameFr);
        print(itemModel!.itemsUnitefr);
        selectedUnite = unites.firstWhere((unite) => unite.uniteNameFr == itemModel!.itemsUnitefr);
        update();
      }
    } catch (e) {
      print("Error fetching unites: $e");
      dialog.showErrorSnack("Error", "Failed to fetch unites");
    }
  }

  void addcolor(Color color) {
    if (!listColor.contains(color)) {
      listColor.add(color);
      colortostring();
    }
    update();
  }

  void colortostring() {
    colorsStringadd.clear();
    colorsStringdelete.clear();
    for (Color color in listColor) {
      if (!oldlistColor.contains(color)) {
        String colorString = color.value.toRadixString(16);

        colorsStringadd.add(colorString);
      }
    }
    for (Color color in oldlistColor) {
      if (!listColor.contains(color)) {
        String colorString = color.value.toRadixString(16);

        colorsStringdelete.add(colorString);
      }
    }

    update();
  }

  Future<void> getcolor(String id) async {
    var response = await crud.get("${AppLink.itemsColor}/$id");
    if (response.statusCode == 200) {
      for (var c in (response.body['colors'] as List)) {
        Color color = Color(int.parse(c, radix: 16));
        listColor.add(color);
        oldlistColor.add(color);
      }

      update();
    }

    update();
  }

  Future<List<String>> updaateimage(List<dynamic> images) async {
    List<String> imagePaths = [];
    try {
      if (images.isNotEmpty) {
        for (File file in images.whereType<File>()) {
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

  Future<List<String>> deleteimage(List<dynamic> images) async {
    List<String> deleteimagessuccess = [];

    try {
      for (var img in imagesString.where((e) => !images.contains(e))) {
        print("deleting image $img");
        var response = await crud.post(AppLink.imagedelete, {"filename": "${AppLink.itemImagesFolder}/$img"});
        if (response.statusCode == 200) {
          deleteimagessuccess.add(response.body['filename']);
          print(response.body);
        }
      }
      print("Deleted images: ${deleteimagessuccess.length}");
    } catch (e) {
      dialog.showErrorSnack("Error", "Failed to delete item images");
      return <String>[];
    }
    return deleteimagessuccess;
  }

  Future<void> updateitem() async {
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
      if (listColor.isEmpty) {
        dialog.showErrorSnack("Error", "Please select at least one color");
        colorselctederoor.value = true;
        return;
      }
      isLoading.value = true;
      colortostring();

      List<String> updaateimagepath = await updaateimage(allimages);
      List<String> deleteimagepath = await deleteimage(allimages);

      var data = {
        "id": itemModel!.itemsId.toString(),
        "items_name_fr": itemName.text,
        "items_name_ar": itemNameArabic.text,
        "items_desc_fr": itemDescription.text,
        "items_desc_ar": itemDescriptionArabic.text,
        "items_size": itemSize.text,
        "items_unite": selectedUnite!.uniteId,
        "items_limite": itemLimite.text,
        "items_price": itemPrice.text,
        "items_cat": selectedCategory!.categoriesId,
        "imagesupdate": updaateimagepath.isEmpty ? [] : updaateimagepath,
        "imagesdelete": deleteimagepath.isEmpty ? [] : deleteimagepath,
        "listcoloradd": colorsStringadd.isEmpty ? [] : colorsStringadd,
        "listcolordelete": colorsStringdelete.isEmpty ? [] : colorsStringdelete,
      };
      print(data);
      var response = await crud.post("${AppLink.items}/${itemModel!.itemsId}", data);

      if (response.statusCode == 201) {
        Get.back();
        isLoading.value = false;
        dialog.showSuccessSnack("Success", "Product updated successfully");
        await Get.find<ItemController>().getitems();
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      dialog.showErrorSnack("Error", "Failed to update product");
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
