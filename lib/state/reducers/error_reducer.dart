import 'package:redux/redux.dart';
import 'package:tracksite/state/actions/actions.dart';

final errorReducer = combineReducers<dynamic>([
  TypedReducer<dynamic, SetErrorAction>(_setError),
]);

dynamic _setError(dynamic state, action) => action.error;
