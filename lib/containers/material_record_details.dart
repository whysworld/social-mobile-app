import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

class MaterialRecordDetails extends StatelessWidget {
  MaterialRecordDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
            store,
            LocalNavigator(Navigator.of(context)),
          ),
      builder: (context, vm) {
        return MaterialRecordDetailsPage(vm.onSave, vm.onSaveAndContinue, vm.materialRecord);
      },
    );
  }
}

class _ViewModel {
  final Function(MaterialRecord) onSave;
  final Function(MaterialRecord) onSaveAndContinue;
  final MaterialRecord materialRecord;

  _ViewModel({
    @required this.onSave,
    @required this.onSaveAndContinue,
    @required this.materialRecord,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onSave: (materialRecord) =>
          store.dispatch(AddOrEditMaterialRecordAction(materialRecord)),
      onSaveAndContinue: (materialRecord) =>
          store.dispatch(SaveAndAddMoreMaterialRecordAction(navigator, materialRecord)),
      materialRecord: store.state.selectedMaterialRecord,
    );
  }
}
