import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/actions/actions.dart';

final reportsInfoReducer = combineReducers<ReportsInfo>([
  TypedReducer<ReportsInfo, SetTodayTotalTimeAction>(_setTodayTotalTimeAction),
  TypedReducer<ReportsInfo, SetWeekTotalTimeAction>(_setWeekTotalTimeAction),
]);

ReportsInfo _setTodayTotalTimeAction(ReportsInfo reportsInfo, action) =>
    reportsInfo.copyWith(
        todayTotalTimeInMinutes: action.todayTotalTimeInMinutes);
ReportsInfo _setWeekTotalTimeAction(ReportsInfo reportsInfo, action) =>
    reportsInfo.copyWith(
        thisWeekTotalTimeInMinutes: action.thisWeekTotalTimeInMinutes);
