class StoresModel {
  int? storesId;
  String? storesNom;
  double? storesLat;
  double? storesLong;

  StoresModel({this.storesId, this.storesNom, this.storesLat, this.storesLong});

  StoresModel.fromJson(Map<String, dynamic> json) {
    storesId = json['Stores_id'];
    storesNom = json['Stores_nom'];
    storesLat = double.parse(json['Stores_lat']);
    storesLong = double.parse(json['Stores_long']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Stores_id'] = storesId;
    data['Stores_nom'] = storesNom;
    data['Stores_lat'] = storesLat;
    data['Stores_long'] = storesLong;
    return data;
  }
}
