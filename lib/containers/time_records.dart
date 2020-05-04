import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

class TimeRecords extends StatelessWidget {
  TimeRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return TimeRecordsPage(
          vm.onTapTimeRecord,
          vm.onTapDeleteTimeRecord,
          vm.date,
          vm.todayWorkTime,
          vm.trackHours,
          vm.timeRecords,
          vm.quantityTimeRecords,
        );
      },
    );
  }
}

class _ViewModel {
  final Function onTapTimeRecord;
  final Function onTapDeleteTimeRecord;
  final DateTime date;
  final int todayWorkTime;
  final int quantityTimeRecords;
  final List<TimeRecord> timeRecords;
  final bool trackHours;

  _ViewModel({
    @required this.onTapTimeRecord,
    @required this.onTapDeleteTimeRecord,
    @required this.date,
    @required this.todayWorkTime,
    @required this.quantityTimeRecords,
    @required this.timeRecords,
    @required this.trackHours,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    List<TimeRecord> timeRecords = store.state.timeRecords;
    return _ViewModel(
      onTapTimeRecord: (timeRecord) =>
          store.dispatch(SetSelectedTimeRecordAction(timeRecord)),
      onTapDeleteTimeRecord: (timeRecord) =>
          store.dispatch(DeleteTimeRecordAction(timeRecord)),
      date: store.state.selectedReport.date,
      todayWorkTime:
          totalMinutesTimeRecords(store.state.trackHours, timeRecords),
      quantityTimeRecords: timeRecords.length,
      timeRecords: timeRecords,
      trackHours: store.state.trackHours,
    );
  }
}
