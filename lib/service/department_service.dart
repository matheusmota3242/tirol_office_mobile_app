import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/model/department.dart';
import 'package:tirol_office_mobile_app/service/abstract_service.dart';

class DepartmentService implements AbstractService<Department> {
  static final collection =
      FirebaseFirestore.instance.collection('departments');

  @override
  Future<void> remove(String id) async {
    await collection.doc(id).update({'active': false});
  }

  @override
  Future<void> save(Department entity) async {
    if (entity.id.isEmpty) {
      await collection.add(entity.toJson());
    } else {
      await collection.doc(entity.id).update(entity.toJson());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAll() async {
    return await collection.get();
  }
}
