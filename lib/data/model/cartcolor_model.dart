import 'package:flutter/material.dart';

class Clr {
  Color? color;
  double? qty;

  Clr({this.color, this.qty});

  Clr.fromJson(Map<String, dynamic> json) {
    color = Color(int.parse(json['color_code2'] ?? 'FFFFFFFF', radix: 16));
    qty = (json['qty'] is num) ? (json['qty'] as num).toDouble() : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_code2'] = color?.value.toRadixString(16);
    data['qty'] = qty;
    return data;
  }
}
