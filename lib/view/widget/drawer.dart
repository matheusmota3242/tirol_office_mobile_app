import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/screen/maintenance/maintenance_list_screen.dart';
import 'package:tirol_office_mobile_app/view/screen/service_unit/service_unit_screen.dart';

import '../../theme/theme.dart';
import '../screen/service_provider.dart/service_provider_screen.dart';

class MyDrawer {
  static String serviceUnitsTitle = 'Unidades';
  static String maintenancesTitle = 'Manutenções';
  static String serviceProvidersTitle = 'Prestadores de serviço';

  static drawer(BuildContext context, String actualScreenTitle) => Drawer(
          child: ListView(
        children: [
          Container(
              height: 120,
              decoration: const BoxDecoration(color: MyTheme.primaryColor),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.white, size: 36),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              )),
          ListTile(
            title: Text(
              serviceUnitsTitle,
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            leading: const Icon(Icons.house),
            onTap: () {
              if (isNotActualScreen(serviceUnitsTitle, actualScreenTitle)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceUnitScreen()));
              }
            },
          ),
          ListTile(
            title: Text(
              maintenancesTitle,
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            leading: const Icon(Icons.healing),
            onTap: () {
              if (isNotActualScreen(maintenancesTitle, actualScreenTitle)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MaintenanceListScreen()));
              }
            },
          ),
          ListTile(
            title: Text(
              serviceProvidersTitle,
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            leading: const Icon(Icons.business_center),
            onTap: () {
              if (isNotActualScreen(serviceProvidersTitle, actualScreenTitle)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ServiceProviderScreen()));
              }
            },
          )
        ],
      ));

  static bool isNotActualScreen(String listTileTitle, String screenTitle) =>
      listTileTitle.toLowerCase() != screenTitle.toLowerCase();
}
