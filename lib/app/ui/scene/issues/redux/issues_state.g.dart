// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IssuesState extends IssuesState {
  @override
  final bool isLoading;
  @override
  final String loadingErrorMessage;
  @override
  final List<IssueModel> issues;

  factory _$IssuesState([void Function(IssuesStateBuilder) updates]) =>
      (new IssuesStateBuilder()..update(updates)).build();

  _$IssuesState._({this.isLoading, this.loadingErrorMessage, this.issues}) : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('IssuesState', 'isLoading');
    }
    if (issues == null) {
      throw new BuiltValueNullFieldError('IssuesState', 'issues');
    }
  }

  @override
  IssuesState rebuild(void Function(IssuesStateBuilder) updates) => (toBuilder()..update(updates)).build();

  @override
  IssuesStateBuilder toBuilder() => new IssuesStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IssuesState &&
        isLoading == other.isLoading &&
        loadingErrorMessage == other.loadingErrorMessage &&
        issues == other.issues;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, isLoading.hashCode), loadingErrorMessage.hashCode), issues.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IssuesState')
          ..add('isLoading', isLoading)
          ..add('loadingErrorMessage', loadingErrorMessage)
          ..add('issues', issues))
        .toString();
  }
}

class IssuesStateBuilder implements Builder<IssuesState, IssuesStateBuilder> {
  _$IssuesState _$v;

  bool _isLoading;

  bool get isLoading => _$this._isLoading;

  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  String _loadingErrorMessage;

  String get loadingErrorMessage => _$this._loadingErrorMessage;

  set loadingErrorMessage(String loadingErrorMessage) => _$this._loadingErrorMessage = loadingErrorMessage;

  List<IssueModel> _issues;

  List<IssueModel> get issues => _$this._issues;

  set issues(List<IssueModel> issues) => _$this._issues = issues;

  IssuesStateBuilder();

  IssuesStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _loadingErrorMessage = _$v.loadingErrorMessage;
      _issues = _$v.issues;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IssuesState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IssuesState;
  }

  @override
  void update(void Function(IssuesStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$IssuesState build() {
    final _$result =
        _$v ?? new _$IssuesState._(isLoading: isLoading, loadingErrorMessage: loadingErrorMessage, issues: issues);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
