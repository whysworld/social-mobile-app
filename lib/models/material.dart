import 'package:tracksite/models/models.dart';

//Have to name it model as it have conflicts with flutter/material
class MaterialModel extends BaseModel {
  String name;
  String unit;

  MaterialModel({id, name})
      : this.name = name ?? '',
        super(id: id);

  MaterialModel.fromDynamic(Map<dynamic, dynamic> fromDy) {
    this.id = fromDy['id'].toString();
    name = fromDy['name'];
    unit = fromDy['unit'];
  }
    // TODO: unify this when aligning the API version
    MaterialModel.fromDynamicV2(Map<dynamic, dynamic> fromDy) {
    this.id = fromDy['id'].toString();
    name = fromDy['name'];
    unit = fromDy['unit']['name'];
  }

  toJson() {
    return {'name': name};
  }
}
