import 'package:time_tracker/app/ui/scene/issues/redux/issues_action.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_state.dart';
import 'package:time_tracker/redux/redux.dart';

class IssuesRedmineMiddleWare extends Middleware<IssuesState> {
  @override
  IssuesState afterAction(Store<IssuesState> store, ActionType action, IssuesState state) {
    if (action is DoLoadRedmineInfoAction) {
      store.dispatch(DoLoadIssuesAction());
    }
    if (action is DoLoadIssuesAction) {
      store.dispatch(DoLoadActivitiesAction());
    }

    return super.afterAction(store, action, state);
  }
}
