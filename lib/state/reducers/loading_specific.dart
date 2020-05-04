import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';

final loadingSpecificReducer = combineReducers<bool>([
  TypedReducer<bool, AddAndSelectProjectAction>(_setTrue),
  TypedReducer<bool, EditSelectedReportAction>(_setFalse),
  TypedReducer<bool, AddAndSelectMaterialAction>(_setTrue),
  TypedReducer<bool, SetSelectedMaterialRecordAction>(_setFalse),
]);

bool _setTrue(bool state, action) => true;

bool _setFalse(bool state, action) => false;
