import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_action.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_state.dart';
import 'package:time_tracker/app/ui/scene/issues/view/issue_search.dart';
import 'package:time_tracker/app/ui/scene/issues/view/issues_list.dart';
import 'package:time_tracker/redux/redux.dart';

class IssuesView extends StatefulWidget {
  @override
  _IssuesViewState createState() => _IssuesViewState();
}

class _IssuesViewState extends State<IssuesView> with AfterLayoutMixin<IssuesView> {
  @override
  void afterFirstLayout(BuildContext context) {
    final store = Provider.of<Store<IssuesState>>(context);
    store.dispatch(DoLoadRedmineInfoAction());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Store<IssuesState>>(
      builder: (context, store, _) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              IssueSearch(
                onSearchTap: (text) {
                  store.dispatch(DoSearchIssueAction(text));
                },
              ),
              store.state.loadingErrorMessage != null
                  ? buildErrorMessage(store)
                  : store.state.isLoading
                      ? buildProgressIndicator()
                      : IssuesList(
                          issues: store.state.issues,
                          onIssueTap: (issue) {
                            store.dispatch(OpenTrackerSceneAction(issue));
                          },
                        ),
            ],
          ),
        );
      },
    );
  }

  Widget buildErrorMessage(Store<IssuesState> store) {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(store.state.loadingErrorMessage),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                child: Text("Retry"),
                onPressed: () {
                  store.dispatch(DoLoadIssuesAction());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return Container(
      height: 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
