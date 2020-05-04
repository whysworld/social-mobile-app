import 'package:tracksite/models/models.dart';

class MaterialRecord extends BaseModel {
  String materialName;
  String materialId;
  double quantity;
  String unit;

  MaterialRecord({id, materialName, materialId, quantity, timeRecordId})
      : super(id: id);

  MaterialRecord.fromDynamic(Map<dynamic, dynamic> fromDy) {
    this.id = fromDy['materialId'].toString();
    this.materialId = fromDy['materialId'].toString();
    this.materialName = fromDy['materialName'];
    this.quantity = fromDy['quantity'];
    this.unit = fromDy['unit'];
  }

  //TODO: https://github.com/swat-cat/reduxsample/blob/48568f331168a05f6ec3a0e3c13384c7bb4a4c3f/lib/redux/auth/auth_state.dart#L51
  MaterialRecord.clone(MaterialRecord materialRecordToClone) {
    this.id = materialRecordToClone.id;
    this.materialId = materialRecordToClone.materialId;
    this.materialName = materialRecordToClone.materialName;
    this.quantity = materialRecordToClone.quantity;
    this.unit = materialRecordToClone.unit;
  }

  toJson() {
    return {
      'materialId': materialId,
      'quantity': quantity,
    };
  }
}
