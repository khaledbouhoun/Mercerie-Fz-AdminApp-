class YallidineCompleteModel {
  bool? hasMore;
  int? totalData;
  List<YallidineCompleteData>? data;
  YallidineLinks? links;

  YallidineCompleteModel({this.hasMore, this.totalData, this.data, this.links});

  YallidineCompleteModel.fromJson(Map<String, dynamic> json) {
    hasMore = json['has_more'];
    totalData = json['total_data'];
    if (json['data'] != null) {
      data = <YallidineCompleteData>[];
      json['data'].forEach((v) {
        data!.add(YallidineCompleteData.fromJson(v));
      });
    }
    links = json['links'] != null ? YallidineLinks.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['has_more'] = hasMore;
    data['total_data'] = totalData;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class YallidineCompleteData {
  String? tracking;
  String? orderId;
  String? firstname;
  String? familyname;
  String? contactPhone;
  String? address;
  int? isStopdesk;
  int? stopdeskId;
  String? stopdeskName;
  int? fromWilayaId;
  String? fromWilayaName;
  int? toCommuneId;
  String? toCommuneName;
  int? toWilayaId;
  String? toWilayaName;
  String? productList;
  int? price;
  bool? doInsurance;
  int? declaredValue;
  int? deliveryFee;
  int? freeshipping;
  int? importId;
  String? dateCreation;
  String? dateExpedition;
  String? dateLastStatus;
  String? lastStatus;
  double? taxePercentage;
  int? taxeFrom;
  int? taxeRetour;
  String? parcelType;
  String? parcelSubType;
  bool? hasReceipt;
  double? length;
  double? width;
  double? height;
  double? weight;
  int? hasRecouvrement;
  int? currentCenterId;
  String? currentCenterName;
  int? currentWilayaId;
  String? currentWilayaName;
  int? currentCommuneId;
  String? currentCommuneName;
  String? paymentStatus;
  String? paymentId;
  int? hasExchange;
  String? productToCollect;
  String? label;
  String? pin;
  String? qrText;

  YallidineCompleteData({
    this.tracking,
    this.orderId,
    this.firstname,
    this.familyname,
    this.contactPhone,
    this.address,
    this.isStopdesk,
    this.stopdeskId,
    this.stopdeskName,
    this.fromWilayaId,
    this.fromWilayaName,
    this.toCommuneId,
    this.toCommuneName,
    this.toWilayaId,
    this.toWilayaName,
    this.productList,
    this.price,
    this.doInsurance,
    this.declaredValue,
    this.deliveryFee,
    this.freeshipping,
    this.importId,
    this.dateCreation,
    this.dateExpedition,
    this.dateLastStatus,
    this.lastStatus,
    this.taxePercentage,
    this.taxeFrom,
    this.taxeRetour,
    this.parcelType,
    this.parcelSubType,
    this.hasReceipt,
    this.length,
    this.width,
    this.height,
    this.weight,
    this.hasRecouvrement,
    this.currentCenterId,
    this.currentCenterName,
    this.currentWilayaId,
    this.currentWilayaName,
    this.currentCommuneId,
    this.currentCommuneName,
    this.paymentStatus,
    this.paymentId,
    this.hasExchange,
    this.productToCollect,
    this.label,
    this.pin,
    this.qrText,
  });

  YallidineCompleteData.fromJson(Map<String, dynamic> json) {
    tracking = json['tracking'];
    orderId = json['order_id'];
    firstname = json['firstname'];
    familyname = json['familyname'];
    contactPhone = json['contact_phone'];
    address = json['address'];
    isStopdesk = json['is_stopdesk'];
    stopdeskId = json['stopdesk_id'];
    stopdeskName = json['stopdesk_name'];
    fromWilayaId = json['from_wilaya_id'];
    fromWilayaName = json['from_wilaya_name'];
    toCommuneId = json['to_commune_id'];
    toCommuneName = json['to_commune_name'];
    toWilayaId = json['to_wilaya_id'];
    toWilayaName = json['to_wilaya_name'];
    productList = json['product_list'];
    price = json['price'] is int ? json['price'] : int.tryParse(json['price']?.toString() ?? '0');
    doInsurance = json['do_insurance'] == 1 || json['do_insurance'] == true;
    declaredValue = json['declared_value'] is int ? json['declared_value'] : int.tryParse(json['declared_value']?.toString() ?? '0');
    deliveryFee = json['delivery_fee'] is int ? json['delivery_fee'] : int.tryParse(json['delivery_fee']?.toString() ?? '0');
    freeshipping = json['freeshipping'] is int ? json['freeshipping'] : int.tryParse(json['freeshipping']?.toString() ?? '0');
    importId = json['import_id'];
    dateCreation = json['date_creation'];
    dateExpedition = json['date_expedition'];
    dateLastStatus = json['date_last_status'];
    lastStatus = json['last_status'];
    taxePercentage =
        json['taxe_percentage'] is double ? json['taxe_percentage'] : double.tryParse(json['taxe_percentage']?.toString() ?? '0.0');
    taxeFrom = json['taxe_from'] is int ? json['taxe_from'] : int.tryParse(json['taxe_from']?.toString() ?? '0');
    taxeRetour = json['taxe_retour'] is int ? json['taxe_retour'] : int.tryParse(json['taxe_retour']?.toString() ?? '0');
    parcelType = json['parcel_type'];
    parcelSubType = json['parcel_sub_type'];
    hasReceipt = json['has_receipt'] == 1 || json['has_receipt'] == true;
    length = json['length'] is double ? json['length'] : double.tryParse(json['length']?.toString() ?? '0.0');
    width = json['width'] is double ? json['width'] : double.tryParse(json['width']?.toString() ?? '0.0');
    height = json['height'] is double ? json['height'] : double.tryParse(json['height']?.toString() ?? '0.0');
    weight = json['weight'] is double ? json['weight'] : double.tryParse(json['weight']?.toString() ?? '0.0');
    hasRecouvrement =
        json['has_recouvrement'] is int ? json['has_recouvrement'] : int.tryParse(json['has_recouvrement']?.toString() ?? '0');
    currentCenterId = json['current_center_id'];
    currentCenterName = json['current_center_name'];
    currentWilayaId = json['current_wilaya_id'];
    currentWilayaName = json['current_wilaya_name'];
    currentCommuneId = json['current_commune_id'];
    currentCommuneName = json['current_commune_name'];
    paymentStatus = json['payment_status'];
    paymentId = json['payment_id'];
    hasExchange = json['has_exchange'] is int ? json['has_exchange'] : int.tryParse(json['has_exchange']?.toString() ?? '0');
    productToCollect = json['product_to_collect'];
    label = json['label'];
    pin = json['pin'];
    qrText = json['qr_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tracking'] = tracking;
    data['order_id'] = orderId;
    data['firstname'] = firstname;
    data['familyname'] = familyname;
    data['contact_phone'] = contactPhone;
    data['address'] = address;
    data['is_stopdesk'] = isStopdesk;
    data['stopdesk_id'] = stopdeskId;
    data['stopdesk_name'] = stopdeskName;
    data['from_wilaya_id'] = fromWilayaId;
    data['from_wilaya_name'] = fromWilayaName;
    data['to_commune_id'] = toCommuneId;
    data['to_commune_name'] = toCommuneName;
    data['to_wilaya_id'] = toWilayaId;
    data['to_wilaya_name'] = toWilayaName;
    data['product_list'] = productList;
    data['price'] = price;
    data['do_insurance'] = doInsurance;
    data['declared_value'] = declaredValue;
    data['delivery_fee'] = deliveryFee;
    data['freeshipping'] = freeshipping;
    data['import_id'] = importId;
    data['date_creation'] = dateCreation;
    data['date_expedition'] = dateExpedition;
    data['date_last_status'] = dateLastStatus;
    data['last_status'] = lastStatus;
    data['taxe_percentage'] = taxePercentage;
    data['taxe_from'] = taxeFrom;
    data['taxe_retour'] = taxeRetour;
    data['parcel_type'] = parcelType;
    data['parcel_sub_type'] = parcelSubType;
    data['has_receipt'] = hasReceipt;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['weight'] = weight;
    data['has_recouvrement'] = hasRecouvrement;
    data['current_center_id'] = currentCenterId;
    data['current_center_name'] = currentCenterName;
    data['current_wilaya_id'] = currentWilayaId;
    data['current_wilaya_name'] = currentWilayaName;
    data['current_commune_id'] = currentCommuneId;
    data['current_commune_name'] = currentCommuneName;
    data['payment_status'] = paymentStatus;
    data['payment_id'] = paymentId;
    data['has_exchange'] = hasExchange;
    data['product_to_collect'] = productToCollect;
    data['label'] = label;
    data['pin'] = pin;
    data['qr_text'] = qrText;
    return data;
  }
}

class YallidineLinks {
  String? self;
  String? next;

  YallidineLinks({this.self, this.next});

  YallidineLinks.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['self'] = self;
    data['next'] = next;
    return data;
  }
}
