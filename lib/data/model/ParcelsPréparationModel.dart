class ParcelsPrparationModel {
  String? tracking;
  String? orderId;
  String? firstname;
  String? familyname;
  String? contactPhone;
  String? address;
  int? stopdeskId;
  String? stopdeskName;
  int? fromWilayaId;
  String? fromWilayaName;
  String? toCommuneName;
  int? toWilayaId;
  String? toWilayaName;
  String? productList;
  int? price;
  int? doInsurance;
  int? declaredValue;
  Null length;
  Null height;
  Null width;
  Null weight;
  int? deliveryFee;
  int? freeshipping;
  int? importId;
  String? dateCreation;
  Null dateExpedition;
  String? dateLastStatus;
  String? lastStatus;
  double? taxePercentage;
  int? taxeFrom;
  int? taxeRetour;
  String? parcelType;
  Null parcelSubType;
  Null hasReceipt;
  int? hasRecouvrement;
  Null currentCenterId;
  Null currentCenterName;
  Null currentWilayaId;
  Null currentWilayaName;
  Null currentCommuneId;
  Null currentCommuneName;
  String? paymentStatus;
  Null paymentId;
  int? hasExchange;
  Null productToCollect;
  String? label;
  String? pin;
  String? qrText;

  ParcelsPrparationModel({
    this.tracking,
    this.orderId,
    this.firstname,
    this.familyname,
    this.contactPhone,
    this.address,
    this.stopdeskId,
    this.stopdeskName,
    this.fromWilayaId,
    this.fromWilayaName,
    this.toCommuneName,
    this.toWilayaId,
    this.toWilayaName,
    this.productList,
    this.price,
    this.doInsurance,
    this.declaredValue,
    this.length,
    this.height,
    this.width,
    this.weight,
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

  ParcelsPrparationModel.fromJson(Map<String, dynamic> json) {
    tracking = json['tracking'];
    orderId = json['order_id'];
    firstname = json['firstname'];
    familyname = json['familyname'];
    contactPhone = json['contact_phone'];
    address = json['address'];
    stopdeskId = json['stopdesk_id'];
    stopdeskName = json['stopdesk_name'];
    fromWilayaId = json['from_wilaya_id'];
    fromWilayaName = json['from_wilaya_name'];
    toCommuneName = json['to_commune_name'];
    toWilayaId = json['to_wilaya_id'];
    toWilayaName = json['to_wilaya_name'];
    productList = json['product_list'];
    price = json['price'];
    doInsurance = json['do_insurance'];
    declaredValue = json['declared_value'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    weight = json['weight'];
    deliveryFee = json['delivery_fee'];
    freeshipping = json['freeshipping'];
    importId = json['import_id'];
    dateCreation = json['date_creation'];
    dateExpedition = json['date_expedition'];
    dateLastStatus = json['date_last_status'];
    lastStatus = json['last_status'];
    taxePercentage = json['taxe_percentage'];
    taxeFrom = json['taxe_from'];
    taxeRetour = json['taxe_retour'];
    parcelType = json['parcel_type'];
    parcelSubType = json['parcel_sub_type'];
    hasReceipt = json['has_receipt'];
    hasRecouvrement = json['has_recouvrement'];
    currentCenterId = json['current_center_id'];
    currentCenterName = json['current_center_name'];
    currentWilayaId = json['current_wilaya_id'];
    currentWilayaName = json['current_wilaya_name'];
    currentCommuneId = json['current_commune_id'];
    currentCommuneName = json['current_commune_name'];
    paymentStatus = json['payment_status'];
    paymentId = json['payment_id'];
    hasExchange = json['has_exchange'];
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
    data['stopdesk_id'] = stopdeskId;
    data['stopdesk_name'] = stopdeskName;
    data['from_wilaya_id'] = fromWilayaId;
    data['from_wilaya_name'] = fromWilayaName;
    data['to_commune_name'] = toCommuneName;
    data['to_wilaya_id'] = toWilayaId;
    data['to_wilaya_name'] = toWilayaName;
    data['product_list'] = productList;
    data['price'] = price;
    data['do_insurance'] = doInsurance;
    data['declared_value'] = declaredValue;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    data['weight'] = weight;
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
