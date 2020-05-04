import 'package:redux/redux.dart';
import 'package:tracksite/helpers/helpers.dart';
import 'package:tracksite/services/base.dart';
import 'package:tracksite/services/services.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

List<Middleware<AppState>> appMiddleware(Function(String) updateLocale) {
  return [
    TypedMiddleware<AppState, CheckUserAction>(
      _checkUserAction(updateLocale),
    ),
    TypedMiddleware<AppState, SignInAction>(
      _signIn(updateLocale),
    ),
    TypedMiddleware<AppState, InitAppAction>(
      _initApp(),
    ),
    TypedMiddleware<AppState, UpdateLocaleAction>(
      _updateLocale(updateLocale),
    ),
  ];
}

Middleware<AppState> _checkUserAction(Function(String) updateLocale) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      CustomerSharedPrefernces.subscribe("token", (value) {
        if (value == null) action.navigator.toLogin();
      });

      var isValidToken = await BaseService().refreshToken();
      if (isValidToken) {
        final dynamic token = await CustomerSharedPrefernces.getValue("token");
        var jwt = Jwt.parseJwt(token);

        updateLocale(jwt["LanguageCode"]);
        store.dispatch(
            SetTrackHours(jwt["EntryModeByHours"].toLowerCase() == 'true'));
        store.dispatch(InitAppAction());
        action.navigator.toHome();
      }
    } catch (error) {
      store.dispatch(SetErrorAction(error));
      action.navigator.toLogin();
    }
  };
}

Middleware<AppState> _signIn(Function(String) updateLocale) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      final Tokens loginResponse =
          await LoginService().signInWithUsernameAndPassword(
        username: action.username,
        password: action.password,
      );

      await CustomerSharedPrefernces.setValue("username", action.username);
      await CustomerSharedPrefernces.setValue("password", action.password);
      await CustomerSharedPrefernces.setValue("token", loginResponse.token);
      await CustomerSharedPrefernces.setValue(
          "refreshToken", loginResponse.refreshToken);

      var jwt = Jwt.parseJwt(loginResponse.token);

      updateLocale(jwt["LanguageCode"]);
      store.dispatch(
          SetTrackHours(jwt["EntryModeByHours"].toLowerCase() == 'true'));
      store.dispatch(InitAppAction());
      action.navigator.toHome();
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}

Middleware<AppState> _initApp() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    store.dispatch(LoadReportsAction(store.state.selectedDate));
    try {
      var reportCount = await ReportService().getNumList();
      store.dispatch(SetReportCountAction(reportCount));
    } catch (error) {}
  };
}

Middleware<AppState> _updateLocale(Function(String) updateLocale) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    updateLocale(action.locale);

    try {
      var languages = await LanguageService().getList();
      await LanguageService().updateLanguage(languages
          .firstWhere(
            (language) => language.code == action.locale,
            orElse: () => new Language(id: -1),
          )
          .code);
    } catch (error) {
      store.dispatch(SetErrorAction(error));
    }
  };
}
