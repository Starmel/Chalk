import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:time_tracker/app/ui/app_colors.dart';
import 'package:time_tracker/domain/model/issue_model.dart';

class IssuesList extends StatelessWidget {
  final List<IssueModel> issues;
  final Function(IssueModel) onIssueTap;

  const IssuesList({Key key, this.issues, this.onIssueTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: issues.isNotEmpty ? buildListView() : emptyPlaceholder(),
    );
  }

  Widget emptyPlaceholder() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text("No issues"),
    );
  }

  Widget buildListView() {
    return Column(
      children: <Widget>[
        buildTableTitle(),
        buildTable(),
      ],
    );
  }

  Widget buildTableTitle() {
    final issuesCount = issues.length;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          issuesCount > 0 ? "Your $issuesCount latest issues" : "You have not issues",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Widget buildTable() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.border,
              width: 0.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildListHeader(),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => Divider(
                  color: AppColors.border,
                  height: 1,
                ),
                shrinkWrap: true,
                itemCount: issues.length,
                itemBuilder: (context, index) => _buildItem(issues[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListHeader() {
    return Container(
      color: Color(0xfff5f5f5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Id", // Yeah
                      style: TextStyle(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Title",
                      style: TextStyle(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Status"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.8,
            color: Colors.amber,
          )
        ],
      ),
    );
  }

  Widget _buildItem(IssueModel issue) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onIssueTap(issue);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    issue.id.toString(),
                    style: TextStyle(),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      issue.project.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(issue.subject),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(issue.tracker.name),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
