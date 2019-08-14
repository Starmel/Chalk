import 'package:built_value/built_value.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';

part 'tracker_state.g.dart';

abstract class TrackerState implements Built<TrackerState, TrackerStateBuilder> {
  bool get isLoading;

  bool get isCommentSending;

  String get comment;

  @nullable
  String get loadingErrorMessage;

  bool get isRunning;

  int get elapsedTime;

  IssueModel get selectedIssue;

  List<ActivityModel> get activities;

  @nullable
  ActivityModel get selectedActivity;

  TrackerState._();

  factory TrackerState([void Function(TrackerStateBuilder) updates]) = _$TrackerState;

  static TrackerState initial(IssueModel issue, List<ActivityModel> activities) => TrackerState(
        (b) => b
          ..loadingErrorMessage = null
          ..isLoading = false
          ..isCommentSending = false
          ..comment = ""
          ..activities = activities
          ..selectedActivity = activities.first
          ..elapsedTime = 0
          ..isRunning = false
          ..selectedIssue = issue,
      );
}
