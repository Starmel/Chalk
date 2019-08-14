import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable()
class IssueModel {
  int id;
  ValueWithId tracker;
  ValueWithId priority;
  ValueWithId project;
  String subject;
  String description;
  @JsonKey(ignore: true)
  ValueWithId selectedActivity;
  @JsonKey(name: "spent_hours")
  double spentHours; //current
  @JsonKey(name: "estimated_hours")
  double estimatedHours; //total
  @JsonKey(name: "assigned_to")
  ValueWithId assignedTo;

  IssueModel();

  static IssueModel fromJson(Map<String, dynamic> json) => _$IssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$IssueModelToJson(this);

  @override
  String toString() {
    return 'IssueModel{id: $id, tracker: $tracker, priority: $priority, project: $project, subject: $subject, description: $description, selectedActivity: $selectedActivity, spentHours: $spentHours, estimatedHours: $estimatedHours, assignedTo: $assignedTo}';
  }
}

@JsonSerializable()
class ValueWithId {
  int id;
  String name;
  @JsonKey(name: 'is_default')
  bool isDefault;

  ValueWithId(this.id, this.name);

  factory ValueWithId.fromJson(Map<String, dynamic> json) => _$ValueWithIdFromJson(json);

  Map<String, dynamic> toJson() => _$ValueWithIdToJson(this);
}
