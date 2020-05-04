import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';

final selectedDateReducer = combineReducers<DateTime>([
  TypedReducer<DateTime, InitAppAction>(_initDate),
  TypedReducer<DateTime, LoadReportsAction>(_setDate),
]);

DateTime _initDate(DateTime state, InitAppAction action) => new DateTime.now();

DateTime _setDate(DateTime state, LoadReportsAction action) {
  return action.date;
}
