import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

class TimeRecordDetails extends StatelessWidget {
  TimeRecordDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
        store,
        LocalNavigator(Navigator.of(context)),
      ),
      builder: (context, vm) => TimeRecordDetailsPage(
          vm.onSave, vm.onSaveAndContinue, vm.trackHours, vm.timeRecord),
    );
  }
}

class _ViewModel {
  final Function(TimeRecord) onSave;
  final Function(TimeRecord) onSaveAndContinue;
  final TimeRecord timeRecord;
  final bool trackHours;

  _ViewModel({
    @required this.onSave,
    @required this.onSaveAndContinue,
    @required this.timeRecord,
    @required this.trackHours,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onSave: (timeRecord) =>
          store.dispatch(AddOrEditTimeRecordAction(timeRecord)),
      onSaveAndContinue: (timeRecord) =>
          store.dispatch(SaveAndAddMoreTimeRecordAction(navigator, timeRecord)),
      timeRecord: store.state.selectedTimeRecord,
      trackHours: store.state.trackHours,
    );
  }
}
