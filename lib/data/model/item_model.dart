class ItemModel {
  int? itemsId;
  String? itemsNameAr;
  String? itemsNameFr;
  String? itemsDescAr;
  String? itemsDescFr;
  String? itemsSize;
  String? itemsUnitefr;
  String? itemsUnitear;
  double? itemsLimite;
  int? itemsActive;
  double? itemsPrice;
  String? itemsDate;
  int? itemsCat;
  List<String>? images;

  ItemModel({
    this.itemsId,
    this.itemsNameAr,
    this.itemsNameFr,
    this.itemsDescAr,
    this.itemsDescFr,
    this.itemsSize,
    this.itemsUnitefr,
    this.itemsUnitear,
    this.itemsLimite,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDate,
    this.itemsCat,
    this.images,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsNameAr = json['items_name_ar'];
    itemsNameFr = json['items_name_fr'];
    itemsDescAr = json['items_desc_ar'];
    itemsDescFr = json['items_desc_fr'];
    itemsSize = json['items_size'];
    itemsUnitefr = json['items_unite_fr'];
    itemsUnitear = json['items_unite_ar'];
    itemsLimite = (json['items_limite'] as num).toDouble();
    itemsActive = json['items_active'];
    itemsPrice = (json['items_price'] as num).toDouble();
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    } else {
      images = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items_id'] = itemsId;
    data['items_name_ar'] = itemsNameAr;
    data['items_name_fr'] = itemsNameFr;
    data['items_desc_ar'] = itemsDescAr;
    data['items_desc_fr'] = itemsDescFr;
    data['items_size'] = itemsSize;
    data['items_unitefr'] = itemsUnitefr;
    data['items_unitear'] = itemsUnitear;
    data['items_limite'] = itemsLimite;
    data['items_active'] = itemsActive;
    data['items_price'] = itemsPrice;
    data['items_date'] = itemsDate;
    data['items_cat'] = itemsCat;
    data['images'] = images;
    return data;
  }
}
