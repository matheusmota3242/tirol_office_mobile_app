import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class MaintenanceDetailItem {
  static Column showMaintenanceDetailItem(String label, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MyTheme.labelStyle),
          const SizedBox(height: 8),
          Text(value),
        ],
      );
}
