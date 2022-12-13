import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/drawer.dart';

class ServiceProviderScreen extends StatelessWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screenTitle = 'PROVEDORES DE SERVIÇO';
    return Scaffold(
      appBar: AppBar(
        title: const Text(screenTitle),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // IconButton(
          //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => EquipmentFormScreen(
          //           equipment: Equipment.defaultInitialization(departmentId)))),
          //   icon: const Icon(Icons.add),
          // )
        ],
      ),
      drawer: MyDrawer.drawer(context, screenTitle),
    );
  }
}
