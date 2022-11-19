import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/equipment.dart';
import 'package:tirol_office_mobile_app/service/abstract_service.dart';

class EquipmentService extends AbstractService<Equipment> {
  static final collection = FirebaseFirestore.instance.collection('equipments');

  @override
  Future<void> remove(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<void> save(Equipment entity) async {
    if (entity.id.isEmpty) {
      await collection.add(entity.toJson());
    } else {
      await collection.doc(entity.id).update(entity.toJson());
    }
  }
}
