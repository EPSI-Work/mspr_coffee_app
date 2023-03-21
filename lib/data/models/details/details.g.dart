// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      price: json['price'] as int,
      description: json['description'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'price': instance.price,
      'description': instance.description,
      'color': instance.color,
    };
