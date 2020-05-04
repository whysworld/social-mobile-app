import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class ProjectService extends BaseService {
  Future add(BaseName customer, String projectName) async {
    var result = await this.post('v2/projects/', {
      'Customer': {'Id': customer.id, 'Name': customer.name},
      'Name': projectName,
    });
    return ListProjectDTO.fromPostDynamic(result);
  }

  Future<List<ListProjectDTO>> getListByName(String name) async {
    var result = await this.get('Projects?Name=$name&includeCustomer=true');
    if (result == null) return new List<ListProjectDTO>();
    return List<ListProjectDTO>.from(
        result.map((r) => ListProjectDTO.fromDynamic(r)));
  }
}
