import 'package:intl/intl.dart';

class ReportCount {
  DateTime date;
  int count;

  ReportCount({
    this.date,
    this.count,
  });

  ReportCount.fromDynamic(Map<String, dynamic> fromDy) {
    this.date = DateFormat("y-M-d").parse(fromDy['date']);
    this.count = fromDy['count'];
  }
}
