import 'package:tracksite/models/models.dart';

class SetReportCountAction {
  final List<ReportCount> reportCounts;

  SetReportCountAction(this.reportCounts);

  @override
  String toString() {
    return 'SetReportCountAction{reportCounts: $reportCounts}';
  }
}

class UpdateReportCountAction {
  final DateTime date;
  final bool add;

  UpdateReportCountAction(this.date, this.add);

  @override
  String toString() {
    return 'UpdateReportCountAction{date: $date, add: $add}';
  }
}
