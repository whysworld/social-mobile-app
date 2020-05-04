import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/components/components.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/state/state.dart';

class NewProjectDialog extends StatelessWidget {
  NewProjectDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
        store,
        LocalNavigator(Navigator.of(context)),
      ),
      builder: (context, vm) => NewDialog(
        title: Formatter.upperFirstLetter(
            AppLocalizations.of(context).createProject),
        upText:
            Formatter.upperFirstLetter(AppLocalizations.of(context).customer),
        downText: Formatter.upperFirstLetter(
            AppLocalizations.of(context).projectName),
        onSave: vm.onSave,
        service: CustomerService().getListByName,
        isLoading: vm.isLoadingSpecific,
      ),
    );
  }
}

class _ViewModel {
  final Function onSave;
  final bool isLoadingSpecific;

  _ViewModel({
    @required this.onSave,
    @required this.isLoadingSpecific,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onSave: (BaseName customer, String projectName) => store.dispatch(
        AddAndSelectProjectAction(navigator, customer, projectName),
      ),
      isLoadingSpecific: store.state.isLoadingSpecific,
    );
  }
}
