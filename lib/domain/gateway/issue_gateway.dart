import 'package:flutter/cupertino.dart';
import 'package:time_tracker/domain/model/issue_model.dart';

abstract class IssueGateway {
  Future<IssueModel> getDetailIssue({@required int issueId});

  Future<List<IssueModel>> getIssues({@required int limit});

  Future<void> addIssueComment({@required String text});
}
