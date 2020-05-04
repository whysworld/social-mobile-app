import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

final reportsReducer = combineReducers<List<ReportRecord>>([
  TypedReducer<List<ReportRecord>, LoadedReportsAction>(_setReports),
]);

List<ReportRecord> _setReports(List<ReportRecord> state, LoadedReportsAction action) => action.reports;
