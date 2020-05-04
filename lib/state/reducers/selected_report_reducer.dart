import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/actions/actions.dart';

final selectedReportReducer = combineReducers<ReportRecord>([
  TypedReducer<ReportRecord, CleanReportAction>(_cleanReport),
  TypedReducer<ReportRecord, SetSelectedReportAction>(_setSelectedReport),
  TypedReducer<ReportRecord, EditSelectedReportAction>(
      _editSelectedReportAction),
]);

ReportRecord _setSelectedReport(ReportRecord state, action) =>
    ReportRecord.clone(action.report);

ReportRecord _cleanReport(ReportRecord state, action) =>
    new ReportRecord("0", "");

ReportRecord _editSelectedReportAction(ReportRecord state, action) =>
    action.report;
