import 'package:json_annotation/json_annotation.dart';
import 'package:mspr_coffee_app/data/models/models.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final int stock;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final Details details;
  const Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.createdAt,
    required this.details,
  });

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

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

  static List<Product> listFromJson(dynamic str) =>
      List<Product>.from(str.map((x) => Product.fromJson(x)));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      stock: map['stock'],
      createdAt: DateTime.parse(map['created_at']),
      details: Details.fromMap(map['details']),
    );
  }
}
