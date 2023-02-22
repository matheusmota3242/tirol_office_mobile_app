import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class MaintenanceDetailItem {
  static Column showMaintenanceDetailItem(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MyTheme.labelStyle),
          const SizedBox(height: 8),
          Text(value.isNotEmpty ? value : 'Não há.'),
        ],
      );
  static Column showMaintenanceStatusDetailItem(String label, bool status) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MyTheme.labelStyle),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: status ? Colors.green : Colors.yellow),
            child: Icon(status ? Icons.done : Icons.timer, color: Colors.white),
          ),
        ],
      );
}
