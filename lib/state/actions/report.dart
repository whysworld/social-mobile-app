import 'package:tracksite/models/models.dart';

class CleanReportAction {
  CleanReportAction();

  @override
  String toString() {
    return 'CleanReportAction{}';
  }
}

class LoadReportsAction {
  final DateTime date;

  LoadReportsAction(this.date);

  @override
  String toString() {
    return 'LoadReportsAction{date: $date}';
  }
}

class NotLoadedReportsAction {
  @override
  String toString() {
    return 'NotLoadedReportsAction{}';
  }
}

class LoadedReportsAction {
  final List<ReportRecord> reports;

  LoadedReportsAction(this.reports);

  @override
  String toString() {
    return 'LoadedReportsAction{reports: $reports}';
  }
}

class SetTodayTotalTimeAction {
  final int todayTotalTimeInMinutes;

  SetTodayTotalTimeAction(this.todayTotalTimeInMinutes);

  @override
  String toString() {
    return 'SetTodayTotalTimeAction{todayTotalTimeInMinutes: $todayTotalTimeInMinutes}';
  }
}

class SetWeekTotalTimeAction {
  final int thisWeekTotalTimeInMinutes;

  SetWeekTotalTimeAction(this.thisWeekTotalTimeInMinutes);

  @override
  String toString() {
    return 'SetWeekTotalTimeAction{thisWeekTotalTimeInMinutes: $thisWeekTotalTimeInMinutes}';
  }
}

class SetSelectedReportAction {
  final ReportRecord report;

  SetSelectedReportAction(this.report);

  @override
  String toString() {
    return 'SetSelectedReportAction{report: $report}';
  }
}

class EditSelectedReportAction {
  final ReportRecord report;

  EditSelectedReportAction(this.report);

  @override
  String toString() {
    return 'EditSelectedReportAction{report: $report}';
  }
}

class SaveReportAction {
  final LocalNavigator navigator;

  SaveReportAction(this.navigator);

  @override
  String toString() {
    return 'SaveReportAction{navigator: $navigator}';
  }
}

class SetEditedReportAction {
  final bool editedReport;

  SetEditedReportAction(this.editedReport);

  @override
  String toString() {
    return 'SetEditedReportAction{editedReport: $editedReport}';
  }
}

class DeleteReportAction {
  final LocalNavigator navigator;

  DeleteReportAction(this.navigator);

  @override
  String toString() {
    return 'DeleteReportAction{navigator: $navigator}';
  }
}

class AddAndSelectProjectAction {
  final LocalNavigator navigator;
  final BaseName customer;
  final String projectName;

  AddAndSelectProjectAction(this.navigator, this.customer, this.projectName);

  @override
  String toString() {
    return 'AddAndSelectProjectAction{navigator: $navigator, customer: $customer, projectName: $projectName}';
  }
}
