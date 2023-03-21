import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  final int price;
  final String description;
  final String color;
  const Details({
    required this.price,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);

  static _toJsonIri(dynamic data) {
    String text = data.runtimeType.toString();
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    String result = text
        .replaceAllMapped(exp, (Match m) => ('_' + m.group(0)!))
        .toLowerCase();
    if (data != null) {
      return 'api/${result + 's'}/${data.id}';
    }
    return null;
  }

  static List<Details> listFromJson(dynamic str) =>
      List<Details>.from(str.map((x) => Details.fromJson(x)));

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'description': description,
      'color': color,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      price: map['price'],
      description: map['description'],
      color: map['color'],
    );
  }
}
