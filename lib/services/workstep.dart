import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class WorkStepService extends BaseService {
  Future<List> getListByName(String name) async {
    //FIXME: send name to get worksteps
    var result = await this.get('worksteps?Name=$name');
    if (result == null) return new List<MaterialRecord>();
    return List<ListProjectDTO>.from(
        result.map((r) => ListProjectDTO.fromDynamic(r)));
  }
}
