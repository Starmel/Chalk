import 'package:event_bus/event_bus.dart';
import 'package:rxdart/subjects.dart';

final eventBus = EventBus.customController(BehaviorSubject());
