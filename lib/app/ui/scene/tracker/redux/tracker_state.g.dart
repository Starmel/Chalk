// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrackerState extends TrackerState {
  @override
  final bool isLoading;
  @override
  final bool isCommentSending;
  @override
  final String comment;
  @override
  final String loadingErrorMessage;
  @override
  final bool isRunning;
  @override
  final int elapsedTime;
  @override
  final IssueModel selectedIssue;
  @override
  final List<ActivityModel> activities;
  @override
  final ActivityModel selectedActivity;

  factory _$TrackerState([void Function(TrackerStateBuilder) updates]) =>
      (new TrackerStateBuilder()..update(updates)).build();

  _$TrackerState._(
      {this.isLoading,
      this.isCommentSending,
      this.comment,
      this.loadingErrorMessage,
      this.isRunning,
      this.elapsedTime,
      this.selectedIssue,
      this.activities,
      this.selectedActivity})
      : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'isLoading');
    }
    if (isCommentSending == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'isCommentSending');
    }
    if (comment == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'comment');
    }
    if (isRunning == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'isRunning');
    }
    if (elapsedTime == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'elapsedTime');
    }
    if (selectedIssue == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'selectedIssue');
    }
    if (activities == null) {
      throw new BuiltValueNullFieldError('TrackerState', 'activities');
    }
  }

  @override
  TrackerState rebuild(void Function(TrackerStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  TrackerStateBuilder toBuilder() => new TrackerStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrackerState &&
        isLoading == other.isLoading &&
        isCommentSending == other.isCommentSending &&
        comment == other.comment &&
        loadingErrorMessage == other.loadingErrorMessage &&
        isRunning == other.isRunning &&
        elapsedTime == other.elapsedTime &&
        selectedIssue == other.selectedIssue &&
        activities == other.activities &&
        selectedActivity == other.selectedActivity;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc($jc(0, isLoading.hashCode), isCommentSending.hashCode), comment.hashCode),
                            loadingErrorMessage.hashCode),
                        isRunning.hashCode),
                    elapsedTime.hashCode),
                selectedIssue.hashCode),
            activities.hashCode),
        selectedActivity.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TrackerState')
          ..add('isLoading', isLoading)
          ..add('isCommentSending', isCommentSending)
          ..add('comment', comment)
          ..add('loadingErrorMessage', loadingErrorMessage)
          ..add('isRunning', isRunning)
          ..add('elapsedTime', elapsedTime)
          ..add('selectedIssue', selectedIssue)
          ..add('activities', activities)
          ..add('selectedActivity', selectedActivity))
        .toString();
  }
}

class TrackerStateBuilder implements Builder<TrackerState, TrackerStateBuilder> {
  _$TrackerState _$v;

  bool _isLoading;

  bool get isLoading => _$this._isLoading;

  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _isCommentSending;

  bool get isCommentSending => _$this._isCommentSending;

  set isCommentSending(bool isCommentSending) => _$this._isCommentSending = isCommentSending;

  String _comment;

  String get comment => _$this._comment;

  set comment(String comment) => _$this._comment = comment;

  String _loadingErrorMessage;

  String get loadingErrorMessage => _$this._loadingErrorMessage;

  set loadingErrorMessage(String loadingErrorMessage) => _$this._loadingErrorMessage = loadingErrorMessage;

  bool _isRunning;

  bool get isRunning => _$this._isRunning;

  set isRunning(bool isRunning) => _$this._isRunning = isRunning;

  int _elapsedTime;

  int get elapsedTime => _$this._elapsedTime;

  set elapsedTime(int elapsedTime) => _$this._elapsedTime = elapsedTime;

  IssueModel _selectedIssue;

  IssueModel get selectedIssue => _$this._selectedIssue;

  set selectedIssue(IssueModel selectedIssue) => _$this._selectedIssue = selectedIssue;

  List<ActivityModel> _activities;

  List<ActivityModel> get activities => _$this._activities;

  set activities(List<ActivityModel> activities) => _$this._activities = activities;

  ActivityModel _selectedActivity;

  ActivityModel get selectedActivity => _$this._selectedActivity;

  set selectedActivity(ActivityModel selectedActivity) => _$this._selectedActivity = selectedActivity;

  TrackerStateBuilder();

  TrackerStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _isCommentSending = _$v.isCommentSending;
      _comment = _$v.comment;
      _loadingErrorMessage = _$v.loadingErrorMessage;
      _isRunning = _$v.isRunning;
      _elapsedTime = _$v.elapsedTime;
      _selectedIssue = _$v.selectedIssue;
      _activities = _$v.activities;
      _selectedActivity = _$v.selectedActivity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrackerState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TrackerState;
  }

  @override
  void update(void Function(TrackerStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TrackerState build() {
    final _$result = _$v ??
        new _$TrackerState._(
            isLoading: isLoading,
            isCommentSending: isCommentSending,
            comment: comment,
            loadingErrorMessage: loadingErrorMessage,
            isRunning: isRunning,
            elapsedTime: elapsedTime,
            selectedIssue: selectedIssue,
            activities: activities,
            selectedActivity: selectedActivity);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
