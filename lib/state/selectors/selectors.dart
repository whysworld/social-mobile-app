import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';

bool isLoadingSelector(AppState state) => state.isLoading;

DateTime actualDate(AppState state) => state.selectedDate;

int totalMinutesTimeRecords(bool trackTime, List<TimeRecord> timeRecords) {
  return timeRecords.map((r) {
    if (!trackTime) {
      return Formatter.totalMinutes(r.endTime) -
          Formatter.totalMinutes(r.startTime);
    }

    return r.minutes != null ? r.minutes.toInt() : r.totalTime.toInt();
  }).fold(0, (curr, next) => curr + next);
}

String loginError(AppState state) {
  if (state.error is Exception) {
    return state.error.message;
  }

  return null;
}

Map<DateTime, List> reportCountToComponent(List<ReportCount> reportCounts) {
  return new Map.fromIterable(
    reportCounts,
    key: (reportCount) => reportCount.date,
    value: (reportCount) => new List(reportCount.count),
  );
}
