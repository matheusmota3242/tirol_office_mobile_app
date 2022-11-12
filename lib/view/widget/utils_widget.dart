import 'package:flutter/material.dart';

class UtilsWidget {
  static Widget noData = const Center(
      child: Text(
    "Não há dados cadastrados.",
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
  ));

  static Widget loading = const Center(
    child: CircularProgressIndicator(),
  );

  static Widget connectionFailed = const Center(
    child: Text("Erro de conexão.",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
  );

  static Widget unexpectedBehavior = const Center(
      child: Text("Comportamento inesperado.",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)));
}
