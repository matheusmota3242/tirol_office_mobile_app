import 'package:flutter/material.dart';

import '../../../model/maintenance.dart';
import '../../../utils/utils.dart';

class MaintenanceDetailScreen extends StatelessWidget {
  const MaintenanceDetailScreen(
      {Key? key, required this.maintenance, required this.serviceProviderName})
      : super(key: key);
  final Maintenance maintenance;
  final String serviceProviderName;

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
        child: Column(children: [
          Text(serviceProviderName),
          Text(Utils.formatDateTime(maintenance.dateTime)),
          Text(maintenance.problemDescription),
          Text(maintenance.solutionDescription),
        ]),
      ),
    );
  }
}
