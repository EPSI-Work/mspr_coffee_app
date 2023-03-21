// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subtitle: json['subtitle'] as String?,
      stock: json['stock'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subtitle': instance.subtitle,
      'stock': instance.stock,
      'createdAt': instance.createdAt?.toIso8601String(),
      'details': instance.details,
    };
