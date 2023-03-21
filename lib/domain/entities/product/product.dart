import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:mspr_coffee_app/data/models/product/product.dart' as data;
import 'package:mspr_coffee_app/domain/entities/entity.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@Freezed()
class Product with _$Product {
  const Product._();
  const factory Product({
    String? id,
    String? name,
    String? subtitle,
    int? stock,
    DateTime? createdAt,
    Details? details,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  static const empty = Product();

  static List<Product> listFromMapData(dynamic str) {
    return List<Product>.from(str.map((model) => Product.fromDataModel(model)));
  }

  static fromDataModel(data.Product dataModel) {
    return Product.fromJson(dataModel.toMap());
  }

  data.Product toDataModel() {
    return data.Product.fromJson(this.toJson());
  }

  dynamic getProp(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('property not found');
  }
}
