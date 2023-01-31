import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirol_office_mobile_app/dto/service_provider_dto.dart';
import 'package:tirol_office_mobile_app/model/service_provider.dart';

import 'abstract_service.dart';

class ServiceProviderService extends AbstractService<ServiceProvider> {
  static var collection =
      FirebaseFirestore.instance.collection('service-providers');

  @override
  Future<void> remove(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<void> save(ServiceProvider entity) async {
    if (entity.id.isEmpty) {
      await collection.add(entity.toJson());
    } else {
      await collection.doc(entity.id).update(entity.toJson());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAll() async {
    return await collection.get();
  }

  static String getServiceProviderNameById(
      String id, List<ServiceProvider> serviceProviders) {
    return serviceProviders.firstWhere((sp) => sp.id == id).name;
  }
}
