import 'package:redux/redux.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

List<Middleware<AppState>> timeRecordsMiddleware() {
  return [
    TypedMiddleware<AppState, LoadReportsAction>(
      _loadReports(),
    ),
    TypedMiddleware<AppState, AddAndSelectProjectAction>(
      _addAndSelectProject(),
    ),
    TypedMiddleware<AppState, SaveReportAction>(
      _saveReport(),
    ),
    TypedMiddleware<AppState, DeleteReportAction>(
      _deleteReport(),
    ),
    TypedMiddleware<AppState, SaveAndAddMoreTimeRecordAction>(
      _saveAndAddMoreTimeRecord(),
    ),
    TypedMiddleware<AppState, AddAndSelectMaterialAction>(
      _addAndSelectMaterial(),
    ),
    TypedMiddleware<AppState, SaveAndAddMoreMaterialRecordAction>(
      _saveAndAddMoreMaterialRecord(),
    ),
  ];
}

Middleware<AppState> _loadReports() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      var result = await ReportService().getListByDate(action.date);

      //FIXME: Create class and move it to there
      var reports = List<ReportRecord>.from(
          result['reports'].map((r) => ReportRecord.fromDynamic(r)));

      store
          .dispatch(SetTodayTotalTimeAction(result['todayTotalTimeInMinutes']));
      store.dispatch(
          SetWeekTotalTimeAction(result['thisWeekTotalTimeInMinutes']));
      store.dispatch(LoadedReportsAction(reports));
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _addAndSelectProject() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      var project =
          await ProjectService().add(action.customer, action.projectName);

      var report = store.state.selectedReport;
      report.projectId = project.id;
      report.projectName = project.name;

      store.dispatch(EditSelectedReportAction(report));
      action.navigator.pop();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _saveReport() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      var report = store.state.selectedReport;
      report.timeRecords = store.state.timeRecords;
      report.materialRecords = store.state.materialRecords;

      if (report.id == null)
        await ReportService().add(report);
      else
        await ReportService().update(report);

      store.dispatch(LoadReportsAction(store.state.selectedDate));
      store.dispatch(UpdateReportCountAction(store.state.selectedDate, true));

      action.navigator.toHome();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _deleteReport() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      var report = store.state.selectedReport;

      await ReportService().remove(report.id);

      store.dispatch(LoadReportsAction(store.state.selectedDate));
      store.dispatch(UpdateReportCountAction(store.state.selectedDate, false));

      action.navigator.toHome();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _addAndSelectMaterial() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      var material =
          await MaterialService().add(action.materialName, action.unitId);

      var report = store.state.selectedMaterialRecord;
      report.materialId = material.id;
      report.materialName = material.name;
      report.unit = material.unit;

      store.dispatch(SetSelectedMaterialRecordAction(report));
      action.navigator.pop();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _saveAndAddMoreTimeRecord() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      store.dispatch(AddOrEditTimeRecordAction(action.timeRecord));
      store.dispatch(SetSelectedTimeRecordAction(new TimeRecord()));
      action.navigator.pushReplacementTimeRecordDetails();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _saveAndAddMoreMaterialRecord() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      store.dispatch(AddOrEditMaterialRecordAction(action.materialRecord));
      store.dispatch(SetSelectedMaterialRecordAction(new MaterialRecord()));
      action.navigator.pushReplacementMaterialRecordDetails();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}
