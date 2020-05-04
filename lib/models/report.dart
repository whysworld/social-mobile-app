import 'package:intl/intl.dart';
import 'package:tracksite/models/models.dart';

class ReportRecord {
  String id;
  DateTime date;
  String customerId;
  String customerName;
  String projectId;
  String projectName;

  List<TimeRecord> timeRecords = [];
  List<MaterialRecord> materialRecords = [];

  ReportRecord(this.projectId, this.projectName);

  ReportRecord.clone(ReportRecord reportToClone) {
    this.id = reportToClone.id;
    this.date = reportToClone.date;
    this.projectId = reportToClone.projectId;
    this.projectName = reportToClone.projectName;
    this.timeRecords = reportToClone.timeRecords;
    this.materialRecords = reportToClone.materialRecords;
  }

  ReportRecord.fromDynamic(Map<dynamic, dynamic> fromDy) {
    this.id = fromDy['id'].toString();
    this.date = DateFormat("y-M-d").parse(fromDy['date']);
    this.customerId = fromDy['customerId'].toString();
    this.customerName = fromDy['customerName'];
    this.projectId = fromDy['projectId'].toString();
    this.projectName = fromDy['projectName'];
    this.timeRecords = List<TimeRecord>.from(
        fromDy['timeRecords'].map((r) => TimeRecord.fromDynamic(r)));
    this.materialRecords = List<MaterialRecord>.from(
        fromDy['materialRecords'].map((r) => MaterialRecord.fromDynamic(r)));
  }

  toJson() {
    return {
      'projectId': projectId,
      'date': date.toIso8601String(),
      'timeRecords': timeRecords,
      'materialRecords': materialRecords
    };
  }
}
