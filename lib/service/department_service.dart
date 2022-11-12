import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentService {
  static final collection =
      FirebaseFirestore.instance.collection('departments');
}
