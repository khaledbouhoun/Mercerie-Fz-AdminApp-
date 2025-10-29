class UniteModel {
  int? uniteId;
  String? uniteNameFr;
  String? uniteNameAr;

  UniteModel({this.uniteId, this.uniteNameFr, this.uniteNameAr});

  UniteModel.fromJson(Map<String, dynamic> json) {
    uniteId = json['unite_id'];
    uniteNameFr = json['unite_name_fr'];
    uniteNameAr = json['unite_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unite_id'] = uniteId;
    data['unite_name_fr'] = uniteNameFr;
    data['unite_name_ar'] = uniteNameAr;
    return data;
  }
}
