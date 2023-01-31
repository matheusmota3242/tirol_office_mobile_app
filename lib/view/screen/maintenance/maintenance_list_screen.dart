import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tirol_office_mobile_app/dto/equipment_dto.dart';
import 'package:tirol_office_mobile_app/dto/service_provider_dto.dart';
import 'package:tirol_office_mobile_app/model/service_provider.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/service/department_service.dart';
import 'package:tirol_office_mobile_app/service/equipment_service.dart';
import 'package:tirol_office_mobile_app/service/maintenance_service.dart';
import 'package:tirol_office_mobile_app/service/service_provider_service.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/utils/constants.dart';
import 'package:tirol_office_mobile_app/utils/utils.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../dto/department_dto.dart';
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
  var serviceProviderService = ServiceProviderService();
  var departmentService = DepartmentService();
  var equipmentService = EquipmentService();

  var units = <ServiceUnit>[];
  var serviceProviders = <ServiceProviderDTO>[];
  var departments = <DepartmentDTO>[];
  var equipments = <EquipmentDTO>[];

  var unitIds = <String>[Constants.allItemsText];
  var loadingMobx = LoadingMobx();
  var serviceUnitParamMobx = ServiceUnitParamMobx();

  @override
  void initState() {
    super.initState();
    getComplementaryData();
  }

  getComplementaryData() async {
    loadingMobx.setLoading(true);
    await getServiceUnits();
    await getServiceProviders();
    await getDepartments();
    await getEquipments();
    loadingMobx.setLoading(false);
  }

  Future<void> getServiceUnits() async {
    var queryResult = await unitService.getAll();
    if (queryResult.docs.isNotEmpty) {
      units = queryResult.docs
          .map((doc) => ServiceUnit.fromJson(doc.data(), doc.id))
          .toList();
      unitIds.addAll(units.map((u) => u.name).toList());
    }
  }

  Future<void> getServiceProviders() async {
    var queryResult = await serviceProviderService.getAll();
    if (queryResult.docs.isNotEmpty) {
      serviceProviders = queryResult.docs
          .map((doc) => ServiceProviderDTO(doc.id, doc.data()['name']))
          .toList();
    }
  }

  Future<void> getDepartments() async {
    var queryResult = await serviceProviderService.getAll();
    if (queryResult.docs.isNotEmpty) {
      departments = queryResult.docs
          .map((doc) => DepartmentDTO(doc.id, doc.data()['name']))
          .toList();
    }
  }

  Future<void> getEquipments() async {
    var queryResult = await serviceProviderService.getAll();
    if (queryResult.docs.isNotEmpty) {
      equipments = queryResult.docs
          .map((doc) => EquipmentDTO(doc.id, doc.data()['name']))
          .toList();
    }
  }

  String getServiceProviderNameById(String id) =>
      serviceProviders.firstWhere((element) => element.id == id).name;

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
                                          title: Text(
                                            getServiceProviderNameById(
                                                maintenances[index]
                                                    .serviceProviderId),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    maintenances[index].occured
                                                        ? Colors.green
                                                        : Colors.red),
                                          ),
                                          subtitle: Text(Utils.formatDateTime(
                                              maintenances[index].dateTime)),
                                          leading: const Icon(Icons.healing),
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
