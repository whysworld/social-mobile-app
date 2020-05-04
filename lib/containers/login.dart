import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tracksite/pages/pages.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

class Login extends StatelessWidget {
  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(
        store,
        LocalNavigator(Navigator.of(context)),
      ),
      builder: (context, vm) {
        return LoginPage(
          onLoginTap: vm.onLoginTap,
          signInError: vm.signInError,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(String username, String password) onLoginTap;
  final String signInError;

  _ViewModel({
    @required this.onLoginTap,
    @required this.signInError,
  });

  static _ViewModel fromStore(Store<AppState> store, LocalNavigator navigator) {
    return _ViewModel(
      signInError: loginError(store.state),
      onLoginTap: (username, password) async {
        store.dispatch(SignInAction(username, password, navigator));
      },
    );
  }
}
