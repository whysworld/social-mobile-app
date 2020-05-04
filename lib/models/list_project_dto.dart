import 'package:tracksite/models/models.dart';

class ListProjectDTO extends BaseModel {
  String name;
  int customerId;
  String customerName;

  ListProjectDTO({id, name, customerId, customerName}) : super(id: id);

  ListProjectDTO.fromDynamic(Map<dynamic, dynamic> fromDy) {
    super.id = fromDy['id'].toString();
    name = fromDy['name'];
    customerId = fromDy['customerId'];
    customerName = fromDy['customerName'];
  }

  ListProjectDTO.fromPostDynamic(Map<dynamic, dynamic> fromDy) {
    super.id = fromDy['id'].toString();
    name = fromDy['name'];
    customerId = fromDy['customer']['id'];
    customerName = fromDy['customer']['name'];
  }
}
