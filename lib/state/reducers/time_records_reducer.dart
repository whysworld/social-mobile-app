import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

final timeRecordsReducer = combineReducers<List<TimeRecord>>([
  TypedReducer<List<TimeRecord>, CleanReportAction>(_cleanReport),
  TypedReducer<List<TimeRecord>, SetSelectedReportAction>(_setSelectedReport),
  TypedReducer<List<TimeRecord>, AddOrEditTimeRecordAction>(
      _addOrEditTimeRecord),
  TypedReducer<List<TimeRecord>, DeleteTimeRecordAction>(_deleteTimeRecord),
]);

List<TimeRecord> _cleanReport(
        List<TimeRecord> timeRecords, CleanReportAction action) =>
    new List<TimeRecord>();

List<TimeRecord> _setSelectedReport(
        List<TimeRecord> timeRecords, SetSelectedReportAction action) =>
    action.report.timeRecords;

List<TimeRecord> _addOrEditTimeRecord(
    List<TimeRecord> timeRecords, AddOrEditTimeRecordAction action) {
  int index = timeRecords.indexWhere((tr) => tr.id == action.timeRecord.id);
  if (index < 0) return List.from(timeRecords)..add(action.timeRecord);
  return List.from(timeRecords)..[index] = action.timeRecord;
}

List<TimeRecord> _deleteTimeRecord(
    List<TimeRecord> timeRecords, DeleteTimeRecordAction action) {
  return timeRecords..removeWhere((tr) => tr == action.timeRecord);
}
