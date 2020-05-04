import 'dart:math';

import 'package:tracksite/models/models.dart';

class BaseName extends BaseModel {
  String name;

  BaseName({id, name}) : super(id: id);

  BaseName.fromDynamic(Map<dynamic, dynamic> fromDy) {
    super.id = fromDy['id'].toString();
    name = fromDy['name'];
  }

  BaseName.fromStringWithoutId(String name) {
    super.id = Random().nextInt(999).toString();
    this.name = name;
  }
}
