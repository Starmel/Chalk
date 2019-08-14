import 'package:time_tracker/app/event_bus.dart';
import 'package:time_tracker/app/ui/scene/issues/redux/issues_action.dart';
import 'package:uni_links/uni_links.dart';

class DeeplinkObserver {
  static start() async {
    final uri = await getInitialUri();

    if (uri != null) {
      parseAction(uri);
    }
    getUriLinksStream().listen(parseAction, onError: (error) {
      print("DeeplinkObserver.start: got error = $error");
    });
  }

  static parseAction(uri) {
    if (uri.pathSegments[0] == "issue") {
      final issueId = uri.pathSegments[1];
      if (issueId != null) {
        eventBus.fire(DoSearchIssueAction(issueId));
      }
    }
  }
}
