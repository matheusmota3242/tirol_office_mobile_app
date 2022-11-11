import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';

class ServiceUnitService {
  static final collection = FirebaseFirestore.instance.collection('units');

  Future<void> save(ServiceUnit serviceUnit) async {
    if (serviceUnit.id.isEmpty) {
      await collection.add(serviceUnit.toJson());
    } else {
      await collection.doc(serviceUnit.id).update(serviceUnit.toJson());
    }
  }
}
