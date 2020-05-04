import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

final selectedTimeRecordReducer = combineReducers<TimeRecord>([
  TypedReducer<TimeRecord, SetSelectedTimeRecordAction>(
      _setSelectedTimeRecordAction),
]);

TimeRecord _setSelectedTimeRecordAction(
        TimeRecord state, SetSelectedTimeRecordAction action) =>
    TimeRecord.clone(action.timeRecord);
