import 'package:meta/meta.dart';
import 'package:time_tracker/domain/gateway/redmine_gateway.dart';
import 'package:time_tracker/domain/gateway/time_cache_gateway.dart';

abstract class PushTimeUseCase {
  Future<void> push(int issueId, int activityId, int minutes);

  Future<void> syncNotPushed();
}

class PushTimeUseCaseImp extends PushTimeUseCase {
  final RedmineGateway _redmineGateway;
  final TimeCacheGateway _timeCacheGateway;

  PushTimeUseCaseImp({
    @required RedmineGateway redmineGateway,
    @required TimeCacheGateway timeCacheGateway,
  })  : _redmineGateway = redmineGateway,
        _timeCacheGateway = timeCacheGateway;

  @override
  Future<void> push(int issueId, int activityId, int minutes) async {
    if (minutes >= 1) {
      try {
        await _redmineGateway.saveTime(issueId, minutes, activityId);
      } catch (e, s) {
        _timeCacheGateway.addRecord(issueId, activityId, minutes);
        rethrow;
      }
    } else {
      print("DoSaveTimeAction.reduce: lowen than one minute. skip");
    }

    syncNotPushed();
  }

  @override
  Future<void> syncNotPushed() async {
    final records = await _timeCacheGateway.getRecords();

    records.forEach((record) async {
      try {
        await _redmineGateway.saveTime(record.issueId, record.minutes, record.activityId);
        await _timeCacheGateway.removeRecord(record);
      } catch (e) {
        print(e);
        print("PushTimeUseCaseImp.syncNotPushed: Not sync time record = $record");
      }
    });
  }
}
