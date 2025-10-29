import 'package:admin_ecommerce_app/data/model/cartcolor_model.dart';

class CartModel {
  int? prdId;
  int? itemsId;
  double? countitems;
  double? itemspricetotal;
  String? itemsNameAr;
  String? itemsNameFr;
  String? itemsImage;
  String? itemsSize;
  List<Clr>? clr;

  CartModel({
    this.prdId,
    this.itemsId,
    this.countitems,
    this.itemspricetotal,
    this.itemsNameAr,
    this.itemsNameFr,
    this.itemsImage,
    this.itemsSize,
    this.clr,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    prdId = json['prd_id'];
    itemsId = json['items_id'];
    countitems = json['countitems'] != null ? double.tryParse(json['countitems'].toString()) : null;
    itemspricetotal = json['itemspricetotal'] != null ? double.tryParse(json['itemspricetotal'].toString()) : null;
    itemsNameAr = json['items_name_ar'];
    itemsNameFr = json['items_name_fr'];
    itemsImage = json['items_image'];
    itemsSize = json['items_size'];
    if (json['clr'] != null) {
      clr = <Clr>[];
      for (var v in (json['clr'] as List<dynamic>)) {
        clr!.add(Clr.fromJson(v));
      }
    } else {
      clr = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prd_id'] = prdId;
    data['items_id'] = itemsId;
    data['countitems'] = countitems;
    data['itemspricetotal'] = itemspricetotal;
    data['items_name_ar'] = itemsNameAr;
    data['items_name_fr'] = itemsNameFr;
    data['items_image'] = itemsImage;
    data['items_size'] = itemsSize;
    if (clr != null) {
      data['clr'] = clr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
