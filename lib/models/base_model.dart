import 'package:uuid/uuid.dart';

class BaseModel {
  String id;

  BaseModel({id}): this.id = id ?? Uuid().v4();
}
