import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/models/models.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  HomeHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Header(
          selectedDate: vm.selectedDate,
          onDateSelected: vm.onDateSelected,
          onLanguageChangeSelected: vm.onLanguageChangeSelected,
          todayTotalTimeInMinutes: vm.todayTotalTimeInMinutes,
          thisWeekTotalTimeInMinutes: vm.thisWeekTotalTimeInMinutes,
          reportCount: vm.reportCount,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200);
}

class _ViewModel {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Function(String) onLanguageChangeSelected;
  final int todayTotalTimeInMinutes;
  final int thisWeekTotalTimeInMinutes;
  final Map<DateTime, List> reportCount;

  _ViewModel({
    @required this.selectedDate,
    @required this.onDateSelected,
    @required this.onLanguageChangeSelected,
    @required this.todayTotalTimeInMinutes,
    @required this.thisWeekTotalTimeInMinutes,
    @required this.reportCount,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      selectedDate: actualDate(store.state),
      onDateSelected: (date) => store.dispatch(LoadReportsAction(date)),
      onLanguageChangeSelected: (String language) =>
          store.dispatch(UpdateLocaleAction(language)),
      todayTotalTimeInMinutes: store.state.reportsInfo.todayTotalTimeInMinutes,
      thisWeekTotalTimeInMinutes:
          store.state.reportsInfo.thisWeekTotalTimeInMinutes,
      reportCount: reportCountToComponent(store.state.reportCount),
    );
  }
}
