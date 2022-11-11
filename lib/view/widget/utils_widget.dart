import 'package:flutter/material.dart';

class UtilsWidget {
  static Widget noData = const Center(child: Text("Não tem dados."));
  static Widget loading = const Center(
    child: CircularProgressIndicator(),
  );
}
