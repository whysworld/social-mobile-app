import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/state/state.dart';

class NewMaterialDialog extends StatelessWidget {
  NewMaterialDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
        store,
        LocalNavigator(Navigator.of(context)),
      ),
      builder: (context, vm) => NewDialog(
        title: Formatter.upperFirstLetter(
            AppLocalizations.of(context).createMaterial),
        upText: Formatter.upperFirstLetter(AppLocalizations.of(context).unit),
        downText: Formatter.upperFirstLetter(
            AppLocalizations.of(context).materialName),
        onSave: vm.onSave,
        service: UnitService().getListByName,
        isLoading: vm.isLoading,
      ),
    );
  }
}

class _ViewModel {
  final Function(BaseName unit, String materialName) onSave;
  final bool isLoading;

  _ViewModel({
    @required this.onSave,
    @required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onSave: (BaseName unit, String materialName) => store.dispatch(
        AddAndSelectMaterialAction(navigator, materialName, unit.id),
      ),
      isLoading: store.state.isLoading,
    );
  }
}
