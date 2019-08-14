import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  int id;
  String name;

  ActivityModel();

  static ActivityModel fromJson(Map<String, dynamic> json) => _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  @override
  String toString() {
    return 'activity{id: $id, name: $name}';
  }
}
