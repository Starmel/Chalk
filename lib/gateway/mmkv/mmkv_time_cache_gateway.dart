import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/domain/gateway/time_cache_gateway.dart';
import 'package:time_tracker/domain/model/time_cache_model.dart';

enum _Key { timeCache }

class MMkvTimeCacheGateway implements TimeCacheGateway {
  final SharedPreferences prefs;

  MMkvTimeCacheGateway(this.prefs);

  @override
  Future<void> addRecord(int issueId, int activityId, int minutes) async {
    final records = await getRecords();
    var newRecord = TimeCacheModel(
      id: DateTime.now().millisecondsSinceEpoch,
      issueId: issueId,
      activityId: activityId,
      minutes: minutes,
    );
    records.add(newRecord);

    await _saveRecords(records);
  }

  @override
  Future<List<TimeCacheModel>> getRecords() async {
    final jsonString = prefs.getString(_Key.timeCache.toString());
    if (jsonString.isNotEmpty) {
      List list = json.decode(jsonString);

      return list.map((i) => TimeCacheModel.fromMap(i)).toList();
    } else {
      return List();
    }
  }

  remove() {}

  @override
  Future<void> removeRecord(TimeCacheModel record) async {
    final records = await getRecords();
    records.remove(record);

    await _saveRecords(records);
  }

  @override
  Future<void> removeAll() async {
    await _saveRecords(List());
  }

  Future _saveRecords(List<TimeCacheModel> records) async {
    var jsonString = json.encode(
      records.map((r) => r.toMap()).toList(),
    );
    await prefs.setString(_Key.timeCache.toString(), jsonString);
  }
}
