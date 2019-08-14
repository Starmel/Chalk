import 'package:meta/meta.dart';

class TimeCacheModel {
  final int id;
  final int issueId;
  final int activityId;
  final int minutes;

//<editor-fold desc="Data Methods">

  TimeCacheModel({
    @required this.id,
    @required this.issueId,
    @required this.activityId,
    @required this.minutes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeCacheModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          issueId == other.issueId &&
          activityId == other.activityId &&
          minutes == other.minutes);

  @override
  int get hashCode => id.hashCode ^ issueId.hashCode ^ activityId.hashCode ^ minutes.hashCode;

  @override
  String toString() {
    return 'TimeCacheModel{' +
        ' id: $id,' +
        ' issueId: $issueId,' +
        ' activityId: $activityId,' +
        ' minutes: $minutes,' +
        '}';
  }

  TimeCacheModel copyWith({
    int id,
    int issueId,
    int activityId,
    int minutes,
  }) {
    return new TimeCacheModel(
      id: id ?? this.id,
      issueId: issueId ?? this.issueId,
      activityId: activityId ?? this.activityId,
      minutes: minutes ?? this.minutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'issueId': this.issueId,
      'activityId': this.activityId,
      'minutes': this.minutes,
    };
  }

  factory TimeCacheModel.fromMap(Map<String, dynamic> map) {
    return new TimeCacheModel(
      id: map['id'] as int,
      issueId: map['issueId'] as int,
      activityId: map['activityId'] as int,
      minutes: map['minutes'] as int,
    );
  }

//</editor-fold>
}
