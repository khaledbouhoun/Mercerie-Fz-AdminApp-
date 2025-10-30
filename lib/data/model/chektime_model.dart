class ChektimeModel {
  int? chektimeId;
  int? chektimeEmp;
  int? chektimeStore;
  DateTime? checkInTime;

  ChektimeModel({this.chektimeId, this.chektimeEmp, this.chektimeStore, this.checkInTime});

  ChektimeModel.fromJson(Map<String, dynamic> json) {
    chektimeId = json['chektime_id'];
    chektimeEmp = json['chektime_emp'];
    chektimeStore = json['chektime_store'];
    checkInTime = DateTime.parse(json['check_in_time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chektime_id'] = chektimeId;
    data['chektime_emp'] = chektimeEmp;
    data['chektime_store'] = chektimeStore;
    data['check_in_time'] = checkInTime;
    return data;
  }
}
