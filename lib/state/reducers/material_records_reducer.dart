import 'package:redux/redux.dart';
import 'package:tracksite/state/state.dart';
import 'package:tracksite/models/models.dart';

final materialRecordsReducer = combineReducers<List<MaterialRecord>>([
  TypedReducer<List<MaterialRecord>, CleanReportAction>(_cleanReport),
  TypedReducer<List<MaterialRecord>, SetSelectedReportAction>(
      _setSelectedReport),
  TypedReducer<List<MaterialRecord>, AddOrEditMaterialRecordAction>(
      _addOrEditMaterialRecord),
  TypedReducer<List<MaterialRecord>, DeleteMaterialRecordAction>(
      _deleteMaterialRecord),
]);

List<MaterialRecord> _cleanReport(
        List<MaterialRecord> materialRecords, CleanReportAction action) =>
    new List<MaterialRecord>();

List<MaterialRecord> _setSelectedReport(
        List<MaterialRecord> materialRecords, SetSelectedReportAction action) =>
    action.report.materialRecords;

List<MaterialRecord> _addOrEditMaterialRecord(
    List<MaterialRecord> materialRecords,
    AddOrEditMaterialRecordAction action) {
  int index =
      materialRecords.indexWhere((tr) => tr.id == action.materialRecord.id);
  if (index < 0) return List.from(materialRecords)..add(action.materialRecord);
  return List.from(materialRecords)..[index] = action.materialRecord;
}

List<MaterialRecord> _deleteMaterialRecord(
    List<MaterialRecord> materialRecords, DeleteMaterialRecordAction action) {
  return materialRecords..removeWhere((tr) => tr == action.materialRecord);
}
