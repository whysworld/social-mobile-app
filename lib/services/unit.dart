import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class UnitService extends BaseService {
  Future getListByName(String name) async {
    var result = await this.get('units/?name=$name');
    if (result == null) return new List<String>();
    return List<BaseName>.from(
        result.map((r) => BaseName.fromDynamic(r)));
  }
}
