import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

class MaterialRecords extends StatelessWidget {
  MaterialRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return MaterialRecordsPage(
          vm.onTapMaterialRecord,
          vm.onTapDeleteMaterialRecord,
          vm.date,
          vm.materialRecords,
          vm.quantityMaterialRecords,
        );
      },
    );
  }
}

class _ViewModel {
  final Function onTapMaterialRecord;
  final Function onTapDeleteMaterialRecord;
  final DateTime date;
  final int quantityMaterialRecords;
  final List<MaterialRecord> materialRecords;

  _ViewModel({
    @required this.onTapMaterialRecord,
    @required this.onTapDeleteMaterialRecord,
    @required this.date,
    @required this.quantityMaterialRecords,
    @required this.materialRecords,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    List<MaterialRecord> materialRecords = store.state.materialRecords;
    return _ViewModel(
      onTapMaterialRecord: (materialRecord) =>
          store.dispatch(SetSelectedMaterialRecordAction(materialRecord)),
      onTapDeleteMaterialRecord: (materialRecord) =>
          store.dispatch(DeleteMaterialRecordAction(materialRecord)),
      date: store.state.selectedReport.date,
      quantityMaterialRecords: materialRecords.length,
      materialRecords: materialRecords,
    );
  }
}
