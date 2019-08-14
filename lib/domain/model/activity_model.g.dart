// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) {
  return ActivityModel()
    ..id = json['id'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
