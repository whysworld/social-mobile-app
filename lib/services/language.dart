import 'package:tracksite/models/models.dart';
import 'package:tracksite/services/base.dart';

class LanguageService extends BaseService {
  Future<List<Language>> getList() async {
    List result = await this.get('languages?api-version=1.0');
    if (result == null) return new List<Language>();
    return List<Language>.from(result.map((r) => Language.fromDynamic(r)));
  }

  Future<void> updateLanguage(String languageCode) async {
    await this.put('v2/users/language',  languageCode );
  }
}
