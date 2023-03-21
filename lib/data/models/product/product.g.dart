// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      stock: json['stock'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      details: Details.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stock': instance.stock,
      'created_at': instance.createdAt.toIso8601String(),
      'details': instance.details,
    };
