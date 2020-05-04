import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/actions/actions.dart';

final reportCountReducer = combineReducers<List<ReportCount>>([
  TypedReducer<List<ReportCount>, SetReportCountAction>(_setReportCountAction),
  TypedReducer<List<ReportCount>, UpdateReportCountAction>(
      _updateReportCountAction),
]);

List<ReportCount> _setReportCountAction(
        List<ReportCount> reportCounts, SetReportCountAction action) =>
    action.reportCounts;

List<ReportCount> _updateReportCountAction(
    List<ReportCount> reportCounts, action) {
  int index = reportCounts.indexWhere((rc) =>
      rc.date.year == action.date.year &&
      rc.date.month == action.date.month &&
      rc.date.day == action.date.day);
  if (index < 0)
    return List.from(reportCounts)
      ..add(new ReportCount(date: action.date, count: 1));
  return List.from(reportCounts)
    ..[index] = new ReportCount(
        count: reportCounts[index].count + (action.add ? 1 : -1),
        date: reportCounts[index].date);
}
