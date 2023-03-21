import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:mspr_coffee_app/data/models/details/details.dart' as data;
part 'details.freezed.dart';
part 'details.g.dart';

@Freezed()
class Details with _$Details {
  const Details._();
  const factory Details({
    double? price,
    String? description,
    String? color,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
  static const empty = Details();

  static List<Details> listFromMapData(dynamic str) {
    return List<Details>.from(str.map((model) => Details.fromDataModel(model)));
  }

  static fromDataModel(data.Details dataModel) {
    return Details.fromJson(dataModel.toMap());
  }

  data.Details toDataModel() {
    return data.Details.fromJson(this.toJson());
  }

  dynamic getProp(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('property not found');
  }
}
