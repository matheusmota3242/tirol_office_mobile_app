import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/service/maintenance_service.dart';
import 'package:tirol_office_mobile_app/view/screen/maintenance/maintenance_form_screen.dart';

import '../../../model/maintenance.dart';
import '../../../theme/theme.dart';
import '../../widget/utils_widget.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen(
      {Key? key,
      required this.equipmentName,
      required this.equipmentId,
      required this.departmentName,
      required this.departmentId,
      required this.serviceUnitName,
      required this.serviceUnitId})
      : super(key: key);

  final String equipmentName,
      equipmentId,
      departmentName,
      departmentId,
      serviceUnitName,
      serviceUnitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MANUTENÇÕES"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MaintenanceFormScreen(
                      maintenance: Maintenance.defaultInitialization(
                          equipmentId, departmentId, serviceUnitId)))),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                  '$serviceUnitName  >  $departmentName  >  $equipmentName',
                  style: MyTheme.listTileTitleStyle),
              leading: const Icon(Icons.settings),
            ),
            const SizedBox(height: 10),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 48,
              color: Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            const SizedBox(height: 20),
            Flexible(
                child: StreamBuilder(
              stream: MaintenanceService.collection
                  .where('serviceUnitId', isEqualTo: serviceUnitId)
                  .where('departmentId', isEqualTo: departmentId)
                  .where('equipmentId', isEqualTo: equipmentId)
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return UtilsWidget.connectionFailed;
                  case ConnectionState.active:
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      List<Maintenance>? maintenances = snapshot.data!.docs
                          .map((doc) => Maintenance.fromJson(
                              MaintenanceService.convertTimestampToDateTime(
                                  doc.data()),
                              doc.id))
                          .toList();
                      return ListView.builder(
                        itemCount: maintenances.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(maintenances[index].dateTime.toString()),
                        ),
                      );
                    } else {
                      return UtilsWidget.noData;
                    }
                  case ConnectionState.waiting:
                    return UtilsWidget.loading;
                  default:
                    return UtilsWidget.unexpectedBehavior;
                }
              },
            ))
          ],
        ));
  }
}
