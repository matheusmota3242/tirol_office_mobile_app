import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/maintenance.dart';

import '../utils/constants.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getMaintenancesByUnit(
      String unitId) {
    if (unitId == Constants.allItemsText) {
      return collection.snapshots();
    } else {
      return collection.where('serviceUnitId', isEqualTo: unitId).snapshots();
    }
  }
}
