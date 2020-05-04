import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, SignInAction>(_setTrue),
  TypedReducer<bool, InitAppAction>(_setFalse),
  TypedReducer<bool, SetErrorAction>(_setFalse),
  TypedReducer<bool, LoadReportsAction>(_setTrue),
  TypedReducer<bool, LoadedReportsAction>(_setFalse),
  TypedReducer<bool, NotLoadedReportsAction>(_setFalse),
  TypedReducer<bool, SaveReportAction>(_setTrue),
]);

bool _setTrue(bool state, action) => true;

bool _setFalse(bool state, action) => false;
