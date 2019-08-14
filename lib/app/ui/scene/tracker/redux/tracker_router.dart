import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_action.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_state.dart';
import 'package:time_tracker/redux/redux.dart';
import 'package:time_tracker/redux/router_middleware.dart';

class TrackerRouterMiddleWare extends RouterMiddleware<TrackerState> {
  @override
  TrackerState afterAction(Store<TrackerState> store, ActionType action, TrackerState state) {
    if (action is DoCloseTrackerScene) {
      navigator.pop();
    }

    return super.afterAction(store, action, state);
  }
}
