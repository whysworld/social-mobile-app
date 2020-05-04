import 'package:redux/redux.dart';
import 'package:tracksite/state/actions/actions.dart';

final editedReportReducer = combineReducers<bool>([
  TypedReducer<bool, SetEditedReportAction>(_setEditedReportAction),
]);

bool _setEditedReportAction(bool state, action) => action.editedReport;
