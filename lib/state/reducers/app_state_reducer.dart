import 'package:tracksite/models/models.dart';
import './reducers.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      isLoading: loadingReducer(state.isLoading, action),
      isLoadingSpecific: loadingSpecificReducer(state.isLoadingSpecific, action),
      trackHours: trackHoursReducer(state.trackHours, action),
      error: errorReducer(state.error, action),
      selectedDate: selectedDateReducer(state.selectedDate, action),
      reportCount: reportCountReducer(state.reportCount, action),
      reportsInfo: reportsInfoReducer(state.reportsInfo, action),
      reports: reportsReducer(state.reports, action),
      selectedReport: selectedReportReducer(state.selectedReport, action),
      editedReport: editedReportReducer(state.editedReport, action),
      timeRecords: timeRecordsReducer(state.timeRecords, action),
      selectedTimeRecord:
          selectedTimeRecordReducer(state.selectedTimeRecord, action),
      materialRecords: materialRecordsReducer(state.materialRecords, action),
      selectedMaterialRecord:
          selectedMaterialRecordReducer(state.selectedMaterialRecord, action));
}
