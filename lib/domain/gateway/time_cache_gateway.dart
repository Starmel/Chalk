import 'package:time_tracker/domain/model/time_cache_model.dart';

abstract class TimeCacheGateway {
  Future<void> addRecord(int issueId, int activityId, int minutes);

  Future<List<TimeCacheModel>> getRecords();

  Future<void> removeRecord(TimeCacheModel record);

  Future<void> removeAll();
}
