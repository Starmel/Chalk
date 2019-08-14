import 'package:built_value/built_value.dart';
import 'package:time_tracker/domain/model/issue_model.dart';

part 'issues_state.g.dart';

abstract class IssuesState implements Built<IssuesState, IssuesStateBuilder> {
  bool get isLoading;

  @nullable
  String get loadingErrorMessage;

  List<IssueModel> get issues;

  IssuesState._();

  factory IssuesState([void Function(IssuesStateBuilder) updates]) = _$IssuesState;

  static IssuesState initial() => IssuesState(
        (b) => b
          ..loadingErrorMessage = null
          ..isLoading = false
          ..issues = [],
      );
}
