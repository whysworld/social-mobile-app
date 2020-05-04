import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class ReportService extends BaseService {
  Future getListByDate(DateTime date) async {
    var result = await this.get('Reports?Date=${date.toIso8601String()}');
    return result;
  }

  Future<List<ReportCount>> getNumList() async {
    var result = await this.get('reports/GetNumListAsync');
    if (result == null) return new List<ReportCount>();
    return List<ReportCount>.from(
        result.map((r) => ReportCount.fromDynamic(r)));
  }

  Future add(report) async {
    await this.post('report/', report);
  }

  Future update(report) async {
    await this.put('report/${report.id}', report);
  }

  Future remove(String id) async {
    await this.delete('report/$id');
  }
}
