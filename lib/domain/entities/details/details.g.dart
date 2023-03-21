// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Details _$$_DetailsFromJson(Map<String, dynamic> json) => _$_Details(
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$_DetailsToJson(_$_Details instance) =>
    <String, dynamic>{
      'price': instance.price,
      'description': instance.description,
      'color': instance.color,
    };
