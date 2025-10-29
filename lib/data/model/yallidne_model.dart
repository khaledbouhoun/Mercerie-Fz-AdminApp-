import 'package:get/get.dart';

class YallidineModel {
  int? yId;
  int? yUserid;
  String? yName;
  String? yPrenome;
  String? yTel;
  String? yWilaya;
  String? yComunue;
  int? yDelvreytype;
  String? yAgenceAdresse;
  int? stopdeskid;
  int? yTotalprice;
  int? yStatue;
  int? yWeight;
  String? employeeName;
  DateTime? yDatetime;
  int? items;
  RxBool? isLoading = false.obs;

  YallidineModel({
    this.yId,
    this.yUserid,
    this.yName,
    this.yPrenome,
    this.yTel,
    this.yWilaya,
    this.yComunue,
    this.yDelvreytype,
    this.yAgenceAdresse,
    this.stopdeskid,
    this.yTotalprice,
    this.yStatue,
    this.employeeName,
    this.yDatetime,
    this.yWeight,
    this.items,
    this.isLoading,
  });

  YallidineModel.fromJson(Map<String, dynamic> json) {
    yId = json['y_id'];
    yUserid = json['y_userid'];
    yName = json['y_name'];
    yPrenome = json['y_prenome'];
    yTel = json['y_tel'];
    yWilaya = json['y_wilaya'];
    yComunue = json['y_comunue'];
    yDelvreytype = json['y_delvreytype'];
    yAgenceAdresse = json['y_agence__adresse'];
    stopdeskid = json['stopdesk_id'] != null ? int.parse(json['stopdesk_id'].toString()) : null;
    yTotalprice = json['y_totalprice'] != null ? int.parse(json['y_totalprice'].toString()) : null;
    yStatue = json['y_statue'];
    employeeName = json['employee_name'] ?? '';
    yDatetime = json['y_datetime'] != null ? DateTime.parse(json['y_datetime']) : null;
    yWeight = json['y_weight'] != null ? int.parse(json['y_weight'].toString()) : null;
    items = json['items'];
    isLoading = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['y_id'] = yId;
    data['y_userid'] = yUserid;
    data['y_name'] = yName;
    data['y_prenome'] = yPrenome;
    data['y_tel'] = yTel;
    data['y_wilaya'] = yWilaya;
    data['y_comunue'] = yComunue;
    data['y_delvreytype'] = yDelvreytype;
    data['y_agence__adresse'] = yAgenceAdresse;
    data['stopdesk_id'] = stopdeskid;
    data['y_totalprice'] = yTotalprice;
    data['y_statue'] = yStatue;
    data['employee_name'] = employeeName;
    data['y_datetime'] = yDatetime;
    data['y_weight'] = yWeight;
    data['items'] = items;
    return data;
  }
}
