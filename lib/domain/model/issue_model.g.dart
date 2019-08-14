// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueModel _$IssueModelFromJson(Map<String, dynamic> json) {
  return IssueModel()
    ..id = json['id'] as int
    ..tracker = json['tracker'] == null ? null : ValueWithId.fromJson(json['tracker'] as Map<String, dynamic>)
    ..priority = json['priority'] == null ? null : ValueWithId.fromJson(json['priority'] as Map<String, dynamic>)
    ..project = json['project'] == null ? null : ValueWithId.fromJson(json['project'] as Map<String, dynamic>)
    ..subject = json['subject'] as String
    ..description = json['description'] as String
    ..spentHours = (json['spent_hours'] as num)?.toDouble()
    ..estimatedHours = (json['estimated_hours'] as num)?.toDouble()
    ..assignedTo =
        json['assigned_to'] == null ? null : ValueWithId.fromJson(json['assigned_to'] as Map<String, dynamic>);
}

Map<String, dynamic> _$IssueModelToJson(IssueModel instance) => <String, dynamic>{
      'id': instance.id,
      'tracker': instance.tracker,
      'priority': instance.priority,
      'project': instance.project,
      'subject': instance.subject,
      'description': instance.description,
      'spent_hours': instance.spentHours,
      'estimated_hours': instance.estimatedHours,
      'assigned_to': instance.assignedTo,
    };

ValueWithId _$ValueWithIdFromJson(Map<String, dynamic> json) {
  return ValueWithId(
    json['id'] as int,
    json['name'] as String,
  )..isDefault = json['is_default'] as bool;
}

Map<String, dynamic> _$ValueWithIdToJson(ValueWithId instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_default': instance.isDefault,
    };
