import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/maintenance.dart';

import 'abstract_service.dart';

class MaintenanceService extends AbstractService<Maintenance> {
  static var collection = FirebaseFirestore.instance.collection('maintenances');

  @override
  Future<void> remove(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<void> save(Maintenance entity) async {
    if (entity.id.isEmpty) {
      await collection.add(entity.toJson());
    } else {
      await collection.doc(entity.id).update(entity.toJson());
    }
  }

  static Map<String, dynamic> convertTimestampToDateTime(
      Map<String, dynamic> json) {
    Timestamp timestamp = json['dateTime'];
    json['dateTime'] = timestamp.toDate();
    return json;
  }
}
