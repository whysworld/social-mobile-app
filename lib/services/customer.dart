import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class CustomerService extends BaseService {
  Future<List> getList() async {
    var result = await this.get('Customers');
    return result;
  }

  Future<List> getListByName(String name) async {
    var result = await this.get('Customers/?name=$name');
    if (result == null) return new List<BaseName>();
    return List<BaseName>.from(result.map((r) => BaseName.fromDynamic(r)));
  }
}
