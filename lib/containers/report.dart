import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

class Report extends StatelessWidget {
  Report({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
            store,
            LocalNavigator(Navigator.of(context)),
          ),
      builder: (context, vm) {
        return ReportPage(
          vm.onEdit,
          vm.onSave,
          vm.onDelete,
          vm.report,
          vm.totalMinutes,
          vm.timeRecords,
          vm.materialRecords,
          vm.selectedDate,
          vm.editedReport,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(ReportRecord) onEdit;
  final Function() onSave;
  final Function() onDelete;
  final ReportRecord report;
  final int totalMinutes;
  final List<TimeRecord> timeRecords;
  final List<MaterialRecord> materialRecords;
  final DateTime selectedDate;
  final bool editedReport;

  _ViewModel({
    @required this.onEdit,
    @required this.onSave,
    @required this.onDelete,
    @required this.report,
    @required this.totalMinutes,
    @required this.timeRecords,
    @required this.materialRecords,
    @required this.selectedDate,
    @required this.editedReport,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onEdit: (report) => store.dispatch(EditSelectedReportAction(report)),
      onSave: () => store.dispatch(SaveReportAction(navigator)),
      onDelete: () => store.dispatch(DeleteReportAction(navigator)),
      report: store.state.selectedReport,
      totalMinutes: totalMinutesTimeRecords(
          store.state.trackHours, store.state.timeRecords),
      timeRecords: store.state.timeRecords,
      materialRecords: store.state.materialRecords,
      selectedDate: store.state.selectedDate,
      editedReport: store.state.editedReport,
    );
  }
}
