import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

class Splash extends StatelessWidget {
  Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
        store,
        LocalNavigator(Navigator.of(context)),
      ),
      builder: (context, vm) {
        return SplashPage(
          onInit: vm.onInit,
        );
      },
    );
  }
}

class _ViewModel {
  final Function() onInit;

  _ViewModel({
    @required this.onInit,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      onInit: () => store.dispatch(CheckUserAction(navigator)),
    );
  }
}
