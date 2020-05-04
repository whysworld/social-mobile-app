import 'package:tracksite/models/models.dart';

class Language extends BaseModel {
  String name;
  String code;

  Language({id, this.name, this.code}) : super(id: id);

  Language.fromDynamic(Map<dynamic, dynamic> fromDy) {
    super.id = fromDy['id'].toString();
    name = fromDy['name'];
    code = fromDy['code'];
  }
}
