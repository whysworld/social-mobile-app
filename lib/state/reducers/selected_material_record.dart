import 'package:redux/redux.dart';
import 'package:tracksite/models/models.dart';
import 'package:tracksite/state/state.dart';

final selectedMaterialRecordReducer = combineReducers<MaterialRecord>([
  TypedReducer<MaterialRecord, SetSelectedMaterialRecordAction>(
      _setSelectedMaterialRecordAction),
]);

MaterialRecord _setSelectedMaterialRecordAction(
        MaterialRecord state, SetSelectedMaterialRecordAction action) =>
    MaterialRecord.clone(action.materialRecord);
