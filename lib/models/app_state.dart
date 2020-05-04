import 'package:meta/meta.dart';
import 'package:tracksite/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final bool isLoadingSpecific;
  final dynamic error;
  final DateTime selectedDate;
  final List<ReportCount> reportCount;
  final ReportsInfo reportsInfo;
  final List<ReportRecord> reports;
  final ReportRecord selectedReport;
  final bool trackHours;
  final List<TimeRecord> timeRecords;
  final TimeRecord selectedTimeRecord;
  final List<MaterialRecord> materialRecords;
  final MaterialRecord selectedMaterialRecord;

  final bool editedReport;

  AppState({
    this.isLoading = false,
    this.isLoadingSpecific = false,
    this.trackHours,
    this.error,
    this.selectedDate,
    this.reportCount = const [],
    this.reportsInfo = const ReportsInfo.init(0, 0),
    this.reports = const [],
    this.selectedReport,
    this.timeRecords = const [],
    this.selectedTimeRecord,
    this.materialRecords = const [],
    this.selectedMaterialRecord,
    this.editedReport,
  });

  factory AppState.init() => AppState();

  @override
  int get hashCode =>
      isLoading.hashCode ^
      isLoadingSpecific.hashCode ^
      trackHours.hashCode ^
      error.hashCode ^
      selectedDate.hashCode ^
      reportCount.hashCode ^
      reportsInfo.hashCode ^
      reports.hashCode ^
      selectedReport.hashCode ^
      timeRecords.hashCode ^
      selectedTimeRecord.hashCode ^
      materialRecords.hashCode ^
      selectedMaterialRecord.hashCode ^
      editedReport.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isLoadingSpecific == other.isLoadingSpecific &&
          trackHours == other.trackHours &&
          error == other.error &&
          selectedDate == other.selectedDate &&
          reportCount == other.reportCount &&
          reportsInfo == other.reportsInfo &&
          reports == other.reports &&
          selectedReport == other.selectedReport &&
          timeRecords == other.timeRecords &&
          selectedTimeRecord == other.selectedTimeRecord &&
          materialRecords == other.materialRecords &&
          selectedMaterialRecord == other.selectedMaterialRecord &&
          editedReport == other.editedReport;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, isLoadingSpecific: $isLoadingSpecific, trackHours: $trackHours, error: $error, selectedDate: $selectedDate, reportCount: $reportCount, reportsInfo: $reportsInfo, reports: $reports, selectedReport: $selectedReport, timeRecords: $timeRecords, selectedTimeRecord: $selectedTimeRecord, materialRecords: $materialRecords, selectedMaterialRecord: $selectedMaterialRecord, editedReport: $editedReport}';
  }
}
