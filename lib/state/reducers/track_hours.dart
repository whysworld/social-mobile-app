import 'package:redux/redux.dart';
import 'package:tracksite/state/actions/actions.dart';

final trackHoursReducer = combineReducers<bool>([
  TypedReducer<bool, SetTrackHours>(_setTrackHours),
]);

bool _setTrackHours(bool state, action) => action.trackHours;
