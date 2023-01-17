import 'package:flutter/material.dart';

import '../../../model/maintenance.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';

class MaintenanceWidgets {
  static showListTile(Maintenance maintenance) => Column(
        children: [
          ListTile(
            title: Text(maintenance.dateTime.toString()),
            subtitle: Text(maintenance.problemDescription),
            isThreeLine: true,
          )
        ],
      );

  static showMaintenanceItem(DateTime dateTime, String serviceProviderName,
      problemDescription, bool hasOccured) {
    var textPainter = TextPainter(text: TextSpan(text: problemDescription));
    textPainter.height;
    LayoutBuilder(
      builder: (context, constrains) => Container(
        padding: const EdgeInsets.all(24.0),
        height: 100 + textPainter.height,
        child: Stack(children: [
          Positioned(
            child: Text(serviceProviderName, style: MyTheme.labelStyle),
          ),
          Positioned(top: 24, child: Text(Utils.formatDateTime(dateTime)))
        ]),
      ),
    );
  }
}
