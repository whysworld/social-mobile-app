import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class MaterialService extends BaseService {
  Future add(String materialName, String unitId) async {
    var result = await this.post('/v2/materials/', {
      'name': materialName,
      'unitid': unitId,
    });
    return MaterialModel.fromDynamicV2(result);
  }

  Future<List<MaterialModel>> getListByName(String name) async {
    List result = await this.get('Materials/?name=$name');
    if (result == null) return new List<MaterialModel>();
    return List<MaterialModel>.from(
        result.map((r) => MaterialModel.fromDynamic(r)));
  }
}
