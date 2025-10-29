class CashModel {
  int? ordersId;
  int? ordersUsersid;
  String? usersName;
  String? usersPhone;
  double? items;
  int? shop;
  String? shopname;
  double? ordersTotalprice;
  String? employeename;
  int? ordersStatus;

  DateTime? ordersDatetime;

  CashModel({this.ordersId, this.ordersUsersid, this.usersName, this.shop, this.ordersTotalprice, this.ordersStatus, this.ordersDatetime});

  CashModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    usersName = json['users_name'];
    usersPhone = json['users_phone'];
    items = json['items'] != null ? double.tryParse(json['items'].toString()) : null;
    shop = json['shop'];
    shopname = shop == 1 ? 'Bachdjerrah' : 'Belcourt';
    ordersTotalprice = json['orders_totalprice'] != null ? double.tryParse(json['orders_totalprice'].toString()) : null;
    ordersStatus = json['orders_status'];
    employeename = json['employee_name'] ?? '';
    ordersDatetime = json['orders_datetime'] != null ? DateTime.parse(json['orders_datetime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders_id'] = ordersId;
    data['orders_usersid'] = ordersUsersid;
    data['users_name'] = usersName;
    data['users_phone'] = usersPhone;
    data['items'] = items;
    data['shop'] = shop;
    data['orders_totalprice'] = ordersTotalprice;
    data['orders_status'] = ordersStatus;
    data['employee_name'] = employeename;
    data['orders_datetime'] = ordersDatetime;
    return data;
  }
}
