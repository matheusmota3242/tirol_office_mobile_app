import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/maintenance/maintenance_detail_item.dart';

import '../../../model/maintenance.dart';
import '../../../utils/utils.dart';

class MaintenanceDetailScreen extends StatelessWidget {
  const MaintenanceDetailScreen(
      {Key? key,
      required this.maintenance,
      required this.serviceProviderName,
      required this.departmentName,
      required this.equipmentName})
      : super(key: key);
  final Maintenance maintenance;
  final String serviceProviderName;
  final String departmentName;
  final String equipmentName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALHES DA MANUTENÇÃO'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Departamento', departmentName),
            const SizedBox(
              height: 20,
            ),
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Equipamento', equipmentName),
            const SizedBox(
              height: 20,
            ),
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Prestador do serviço', serviceProviderName),
            const SizedBox(
              height: 20,
            ),
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Data', Utils.formatDateTime(maintenance.dateTime)),
            const SizedBox(
              height: 20,
            ),
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Descrição do problema', maintenance.problemDescription),
            const SizedBox(
              height: 20,
            ),
            MaintenanceDetailItem.showMaintenanceDetailItem(
                'Descrição da solução', maintenance.solutionDescription),
          ]),
        ),
      ),
    );
  }
}
