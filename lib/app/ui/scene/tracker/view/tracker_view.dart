import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/ui/app_colors.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_action.dart';
import 'package:time_tracker/app/ui/scene/tracker/redux/tracker_state.dart';
import 'package:time_tracker/app/ui/scene/tracker/view/timer_label.dart';
import 'package:time_tracker/domain/model/activity_model.dart';
import 'package:time_tracker/domain/model/issue_model.dart';
import 'package:time_tracker/redux/redux.dart';

class TrackerView extends StatefulWidget {
  @override
  _TrackerViewState createState() => _TrackerViewState();
}

class _TrackerViewState extends State<TrackerView> {
  final timerLabelKey = GlobalKey<TimerLabelState>();
  final _commentFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Store<TrackerState>>(
      builder: (_, store, __) {
        final state = store.state;
        final issue = state.selectedIssue;
        final screenSize = MediaQuery.of(context).size;

        final saveTime = () {
          final countedTime = timerLabelKey.currentState.countedTime;
          timerLabelKey.currentState.countedTime = 0;

          if (countedTime != 0) {
            store.dispatch(DoSaveTimeAction(countedTime));
          }
        };

        final onActivityButtonTap = () {
          saveTime();
          store.dispatch(DoStartOrPauseTimerAction());
        };
        final onCloseButtonTap = () {
          saveTime();
          store.dispatch(DoCloseTrackerScene());
        };
        final onSelectTrackerTap = (ActivityModel tracker) {
          store.dispatch(DoSelectTrackerAction(tracker));
        };
        final onSendCommentaryButtonTap = () {
          if (state.comment.isNotEmpty) {
            store.dispatch(AddIssueCommentAction(issue.id, state.comment));
          }
        };
        final onTextChange = (String text) {
          store.dispatch(SetCommentAction(text));
        };

        return Center(
          child: Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5.0, // has the effect of softening the shadow
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Container(
                width: screenSize.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(2.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildHeaderBlock(state.isRunning, state.elapsedTime, onActivityButtonTap, onCloseButtonTap),
                    buildDescriptionBlock(store, issue),
                    builtActivitySelection(state.activities, state.selectedActivity, onSelectTrackerTap),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Text("Add comment"),
                    ),
                    buildCommentaryBlock(
                        state.comment, !state.isCommentSending, onTextChange, onSendCommentaryButtonTap)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildHeaderBlock(bool isRunning, int elapsedTime, onActivityButtonTap(), onCloseButtonTap()) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 70,
        color: Color(0xFF363636),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: onActivityButtonTap,
                child: Icon(
                  isRunning ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                  color: Colors.white,
                  size: 46,
                ),
              ),
              TimerLabel(
                key: timerLabelKey,
                elapsedTime: elapsedTime,
                isRunning: isRunning,
              ),
              GestureDetector(
                onTap: onCloseButtonTap,
                child: Icon(
                  FontAwesomeIcons.times,
                  color: Colors.white,
                  size: 46,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDescriptionBlock(Store<TrackerState> store, IssueModel issue) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf2f2f2),
        border: Border.all(
          color: Color(0xFFd7d7d7),
          width: 1,
        ),
        borderRadius: new BorderRadius.all(Radius.circular(2)),
      ),
      margin: EdgeInsets.all(1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              issue.project.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () {
                  print("tap");
                  store.dispatch(OpenIssueInBrowserAction(issue));
                },
                child: Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '#${issue.id} ',
                        style: TextStyle(color: AppColors.accent),
                      ),
                      TextSpan(
                        text: issue.subject,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${issue.assignedTo.name}"),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCommentaryBlock(
      String comment, bool isSendButtonEnabled, onTextChange(String text), onSendCommentaryButtonTap()) {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: AppColors.border,
      ),
      borderRadius: BorderRadius.zero,
    );

    _commentFieldController.value = TextEditingValue(
      text: comment,
      selection: _commentFieldController.value.selection,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _commentFieldController,
              onChanged: onTextChange,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: Colors.red,
                focusedBorder: inputBorder,
                contentPadding: EdgeInsets.all(8),
                border: inputBorder,
                disabledBorder: inputBorder,
                enabledBorder: inputBorder,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: RaisedButton(
              child: Text("Send"),
              onPressed: isSendButtonEnabled
                  ? () {
                      onSendCommentaryButtonTap();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Row builtActivitySelection(
      List<ActivityModel> activities, ActivityModel activeTracker, onSelectTrackerTap(ActivityModel value)) {
    final items = activities
        .map((tracker) => DropdownMenuItem(
              value: tracker,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(tracker.name),
              ),
            ))
        .toList();

    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 1),
            decoration: BoxDecoration(
              color: Color(0xfffafafa),
              borderRadius: BorderRadius.all(Radius.circular(1)),
              border: Border.all(color: Color(0xffcbcbcb), width: 1),
            ),
            child: DropdownButton(
              underline: Container(),
              value: activeTracker,
              items: items,
              onChanged: onSelectTrackerTap,
            ),
          ),
        ),
      ],
    );
  }
}
