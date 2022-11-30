import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/service/maintenance_service.dart';

import '../../../theme/theme.dart';
import '../../widget/utils_widget.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen(
      {Key? key,
      required this.equipmentName,
      required this.equipmentId,
      required this.departmentName,
      required this.serviceUnitName})
      : super(key: key);

  final String equipmentName, equipmentId, departmentName, serviceUnitName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MANUTENÇÕES"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // IconButton(
          //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => )),
          //   icon: const Icon(Icons.add),
          // )
        ],
      ),
      body: StreamBuilder(
          stream: MaintenanceService.collection.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return UtilsWidget.connectionFailed;
              case ConnectionState.active:
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Column(
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
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) => ListTile()))
                    ],
                  );
                } else {
                  return UtilsWidget.noData;
                }
              case ConnectionState.waiting:
                return UtilsWidget.loading;
              default:
                return UtilsWidget.unexpectedBehavior;
            }
          }),
    );
  }
}
