import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/service/maintenance_service.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/utils/constants.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../mobx/loading/loading_mobx.dart';
import '../../../mobx/service_unit_param_mobx.dart/service_unit_param_mobx.dart';
import '../../../model/maintenance.dart';
import '../../../service/service_unit_service.dart';

class MaintenanceListScreen extends StatefulWidget {
  const MaintenanceListScreen({Key? key}) : super(key: key);

  @override
  MaintenanceListScreenState createState() => MaintenanceListScreenState();
}

class MaintenanceListScreenState extends State<MaintenanceListScreen> {
  var service = MaintenanceService();
  var unitService = ServiceUnitService();
  var units = <ServiceUnit>[];
  var unitIds = <String>[Constants.allItemsText];
  var loadingMobx = LoadingMobx();
  var serviceUnitParamMobx = ServiceUnitParamMobx();

  @override
  void initState() {
    super.initState();
    getServiceUnits();
  }

  getServiceUnits() async {
    loadingMobx.setLoading(true);
    var queryResult = await unitService.getAll();
    if (queryResult.docs.isNotEmpty) {
      units = queryResult.docs
          .map((doc) => ServiceUnit.fromJson(doc.data(), doc.id))
          .toList();
      unitIds.addAll(units.map((u) => u.name).toList());
    }

    loadingMobx.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MANUTENÇÕES'),
          centerTitle: true,
          backgroundColor: MyTheme.primaryColor,
        ),
        body: Observer(builder: (context) {
          if (loadingMobx.loading) {
            return UtilsWidget.loading;
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: DropdownButtonFormField(
                        value: Constants.allItemsText,
                        decoration: const InputDecoration(
                          labelText: 'Unidades de serviço',
                          labelStyle: MyTheme.labelStyle,
                          filled: true,
                          prefixIcon: Icon(Icons.business_center),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: unitIds
                            .map((unitId) => DropdownMenuItem(
                                value: unitId, child: Text(unitId)))
                            .toList(),
                        onChanged: (value) {
                          value = ServiceUnitService.getIdByName(value!, units);
                          serviceUnitParamMobx.setValue(value);
                        }),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Observer(builder: (context) {
                    return StreamBuilder(
                        stream: service
                            .getMaintenancesByUnit(serviceUnitParamMobx.value),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.active:
                              if (snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty) {
                                List<Maintenance>? maintenances = snapshot
                                    .data!.docs
                                    .map((doc) => Maintenance.fromJson(
                                        MaintenanceService
                                            .convertTimestampToDateTime(
                                                doc.data()),
                                        doc.id))
                                    .toList();
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: maintenances.length,
                                    itemBuilder: (context, index) => ListTile(
                                          title: Text(maintenances[index].id),
                                        ));
                              } else {
                                return UtilsWidget.noData;
                              }
                            case ConnectionState.waiting:
                              return UtilsWidget.loading;
                            case ConnectionState.none:
                              return UtilsWidget.connectionFailed;
                            default:
                              return UtilsWidget.unexpectedBehavior;
                          }
                        });
                  })
                ],
              ),
            );
          }
        }));
  }
}
