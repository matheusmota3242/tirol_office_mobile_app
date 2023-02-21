import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tirol_office_mobile_app/service/maintenance_service.dart';
import 'package:tirol_office_mobile_app/view/screen/maintenance/maintenance_detail_screen.dart';
import 'package:tirol_office_mobile_app/view/screen/maintenance/maintenance_form_screen.dart';

import '../../../mobx/loading/loading_mobx.dart';
import '../../../model/maintenance.dart';
import '../../../model/service_provider.dart';
import '../../../service/service_provider_service.dart';
import '../../../theme/theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../widget/dialogs.dart';
import '../../widget/utils_widget.dart';

class MaintenanceScreen extends StatefulWidget {
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
  MaintenanceScreenState createState() => MaintenanceScreenState();
}

class MaintenanceScreenState extends State<MaintenanceScreen> {
  var serviceProviders = <ServiceProvider>[];
  var loadingMobx = LoadingMobx();
  var service = MaintenanceService();

  @override
  void initState() {
    super.initState();
    _getServiceDepartments();
  }

  _getServiceDepartments() async {
    loadingMobx.setLoading(true);
    var query = await ServiceProviderService.collection.get();
    if (query.docs.isNotEmpty) {
      setState(() {
        serviceProviders = query.docs
            .map((doc) => ServiceProvider.fromJson(doc.data(), doc.id))
            .toList();
      });
    }
    loadingMobx.setLoading(false);
  }

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
                          widget.equipmentId,
                          widget.departmentId,
                          widget.serviceUnitId)))),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                  '${widget.serviceUnitName}  >  ${widget.departmentName}  >  ${widget.equipmentName}',
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
            Observer(builder: (context) {
              if (loadingMobx.loading) {
                return UtilsWidget.loading;
              } else {
                return Flexible(
                    child: StreamBuilder(
                  stream: MaintenanceService.collection
                      .where('serviceUnitId', isEqualTo: widget.serviceUnitId)
                      .where('departmentId', isEqualTo: widget.departmentId)
                      .where('equipmentId', isEqualTo: widget.equipmentId)
                      .orderBy('dateTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return UtilsWidget.connectionFailed;
                      case ConnectionState.active:
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          List<Maintenance>? maintenances = snapshot.data!.docs
                              .map((doc) => Maintenance.fromJson(
                                  Utils.convertTimestampToDateTime(doc.data()),
                                  doc.id))
                              .toList();
                          return ListView.builder(
                              itemCount: maintenances.length,
                              itemBuilder: (context, index) => ListTile(
                                    title: Text(
                                        ServiceProviderService
                                            .getServiceProviderNameById(
                                                maintenances[index]
                                                    .serviceProviderId,
                                                serviceProviders),
                                        style:
                                            MyTheme.getMaintenanceStatusColor(
                                                maintenances[index].occured)),
                                    subtitle: Text(Utils.formatDateTime(
                                        maintenances[index].dateTime)),
                                    leading: const Icon(Icons.healing),
                                    trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: Constants.editOpionText,
                                          child: Text(Constants.editOpionText),
                                        ),
                                        const PopupMenuItem(
                                          value: Constants.removeOpionText,
                                          child:
                                              Text(Constants.removeOpionText),
                                        )
                                      ],
                                      onSelected: (value) {
                                        if (Constants.editOpionText == value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MaintenanceFormScreen(
                                                          maintenance:
                                                              maintenances[
                                                                  index])));
                                        } else if (Constants.removeOpionText ==
                                            value) {
                                          Dialogs.deleteDialog(
                                              context,
                                              'manutenção de ${ServiceProviderService.getServiceProviderNameById(maintenances[index].serviceProviderId, serviceProviders)}',
                                              service.remove,
                                              maintenances[index].id);
                                        }
                                      },
                                    ),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MaintenanceDetailScreen(
                                                  maintenance:
                                                      maintenances[index],
                                                  serviceProviderName:
                                                      ServiceProviderService
                                                          .getServiceProviderNameById(
                                                              maintenances[
                                                                      index]
                                                                  .serviceProviderId,
                                                              serviceProviders),
                                                  departmentName:
                                                      widget.departmentName,
                                                  equipmentName:
                                                      widget.equipmentName,
                                                ))),
                                  ));
                        } else {
                          return UtilsWidget.noData;
                        }
                      case ConnectionState.waiting:
                        return UtilsWidget.loading;
                      default:
                        return UtilsWidget.unexpectedBehavior;
                    }
                  },
                ));
              }
            })
          ],
        ));
  }
}
