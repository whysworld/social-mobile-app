import 'package:meta/meta.dart';

@immutable
class ReportsInfo {
  final int todayTotalTimeInMinutes;
  final int thisWeekTotalTimeInMinutes;

  ReportsInfo({
    @required this.todayTotalTimeInMinutes,
    @required this.thisWeekTotalTimeInMinutes,
  });

  const ReportsInfo.init(
    this.todayTotalTimeInMinutes,
    this.thisWeekTotalTimeInMinutes,
  );

  ReportsInfo copyWith({
    int todayTotalTimeInMinutes,
    int thisWeekTotalTimeInMinutes,
  }) {
    return new ReportsInfo(
      todayTotalTimeInMinutes:
          todayTotalTimeInMinutes ?? this.todayTotalTimeInMinutes,
      thisWeekTotalTimeInMinutes:
          thisWeekTotalTimeInMinutes ?? this.thisWeekTotalTimeInMinutes,
    );
  }
}
