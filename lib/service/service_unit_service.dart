import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/service/abstract_service.dart';
import 'package:tirol_office_mobile_app/utils/constants.dart';

class ServiceUnitService implements AbstractService<ServiceUnit> {
  static final collection = FirebaseFirestore.instance.collection('units');

  @override
  Future<void> save(ServiceUnit serviceUnit) async {
    if (serviceUnit.id.isEmpty) {
      await collection.add(serviceUnit.toJson());
    } else {
      await collection.doc(serviceUnit.id).update(serviceUnit.toJson());
    }
  }

  @override
  Future<void> remove(String id) async {
    await collection.doc(id).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAll() async {
    return await collection.get();
  }

  static String getIdByName(String name, List<ServiceUnit> units) {
    if (Constants.allItemsText == name) {
      return name;
    }
    return units.firstWhere((unit) => unit.name == name).id;
  }
}
