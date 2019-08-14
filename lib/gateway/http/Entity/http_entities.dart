import 'dart:convert';

String createTimeEntriesBody(int issueId, int minutes, int activityId) {
  return json.encode({
    "time_entry": {
      "issue_id": issueId,
      "hours": minutes.toDouble() / 60,
      "activity_id": activityId,
    },
  });
}

String createIssueNoteBody(String note) {
  return json.encode({
    "issue": {
      "notes": note,
    }
  });
}
