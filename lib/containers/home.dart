import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return HomePage(
          onHorizontalDrag: vm.onHorizontalDrag,
          reports: vm.reports,
          onAddReportTap: vm.onAddReportTap,
          onReportTap: vm.onReportTap,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(DragEndDetails) onHorizontalDrag;
  final List<ReportRecord> reports;
  final Function() onAddReportTap;
  final Function(ReportRecord) onReportTap;

  _ViewModel({
    @required this.onHorizontalDrag,
    @required this.reports,
    @required this.onAddReportTap,
    @required this.onReportTap,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onHorizontalDrag: (DragEndDetails action) {
        if (action.primaryVelocity != 0) {
          DateTime newDate;
          if (action.primaryVelocity.compareTo(0) == -1)
            newDate = actualDate(store.state).add(new Duration(days: 1));
          else
            newDate = actualDate(store.state).subtract(new Duration(days: 1));

          store.dispatch(LoadReportsAction(newDate));
        }
      },
      reports: store.state.reports,
      onAddReportTap: () => store.dispatch(CleanReportAction()),
      onReportTap: (ReportRecord report) =>
          store.dispatch(SetSelectedReportAction(report)),
    );
  }
}
