import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/middleware/notification_middleware.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_router.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_state.dart';
import 'package:time_tracker/app/ui/scene/tracker/view/tracker_view.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';
import 'package:time_tracker/redux/redux.dart';

class TrackerScene extends StatefulWidget {
  static const navigationKey = "TrackerScene";
  final IssueModel issueModel;
  final List<ActivityModel> activities;

  TrackerScene(this.issueModel, this.activities);

  @override
  _TrackerSceneState createState() => _TrackerSceneState();
}

class _TrackerSceneState extends State<TrackerScene> {
  Store<TrackerState> store;

  @override
  void initState() {
    store = Store<TrackerState>(
      initialState: TrackerState.initial(widget.issueModel, widget.activities),
      middlewares: [
        TrackerRouterMiddleWare(),
        NotificationMiddleware(context),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.45),
      body: ChangeNotifierProvider(
        builder: (_) => store,
        child: TrackerView(),
      ),
    );
  }
}
