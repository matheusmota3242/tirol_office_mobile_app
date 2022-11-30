import 'package:flutter/material.dart';

import '../../../model/maintenance.dart';

class MaintenanceListTile {
  static showListTile(Maintenance maintenance) => Column(
        children: [
          ListTile(
            title: Text(maintenance.dateTime.toString()),
            subtitle: Text(maintenance.description),
            isThreeLine: true,
          )
        ],
      );
}
