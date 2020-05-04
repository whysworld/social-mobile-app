import 'package:tracksite/models/models.dart';

class SetSelectedMaterialRecordAction {
  final MaterialRecord materialRecord;

  SetSelectedMaterialRecordAction(this.materialRecord);

  @override
  String toString() {
    return 'SetSelectedMaterialRecordAction{materialRecord: $materialRecord}';
  }
}

class SaveAndAddMoreMaterialRecordAction {
  final LocalNavigator navigator;
  final MaterialRecord materialRecord;

  SaveAndAddMoreMaterialRecordAction(this.navigator, this.materialRecord);

  @override
  String toString() {
    return 'SaveAndAddMoreMaterialRecordAction{navigator: $navigator, materialRecord: $materialRecord}';
  }
}

class AddOrEditMaterialRecordAction {
  final MaterialRecord materialRecord;

  AddOrEditMaterialRecordAction(this.materialRecord);

  @override
  String toString() {
    return 'AddOrEditMaterialRecordAction{materialRecord: $materialRecord}';
  }
}

class DeleteMaterialRecordAction {
  final MaterialRecord materialRecord;

  DeleteMaterialRecordAction(this.materialRecord);

  @override
  String toString() {
    return 'DeleteMaterialRecordAction{materialRecord: $materialRecord}';
  }
}

class AddAndSelectMaterialAction {
  final LocalNavigator navigator;
  final String materialName;
  final String unitId;

  AddAndSelectMaterialAction(this.navigator, this.materialName, this.unitId);

  @override
  String toString() {
    return 'AddAndSelectMaterialAction{navigator: $navigator, materialName: $materialName, unitId: $unitId}';
  }
}
