import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

List<Middleware<AppState>> editReportFlagMiddleware() {
  return [
    TypedMiddleware<AppState, CleanReportAction>(
      _setEditReport(false),
    ),
    TypedMiddleware<AppState, SetSelectedReportAction>(
      _setEditReport(false),
    ),
    TypedMiddleware<AppState, EditSelectedReportAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, AddOrEditMaterialRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, SaveAndAddMoreMaterialRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, DeleteMaterialRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, AddOrEditTimeRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, SaveAndAddMoreTimeRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, DeleteTimeRecordAction>(
      _setEditReport(true),
    ),
    TypedMiddleware<AppState, AddAndSelectProjectAction>(
      _setEditReport(true),
    ),
  ];
}

Middleware<AppState> _setEditReport(bool edit) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    store.dispatch(SetEditedReportAction(edit));
  };
}
