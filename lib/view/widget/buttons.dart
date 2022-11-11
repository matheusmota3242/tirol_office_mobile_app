import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class Buttons {
  static const minimumWidth = 90.0;
  static const minimumHeight = 50.0;
  static const fontSize = 17.0;

  static Widget submitButton({required Function submitCallback}) {
    return ElevatedButton(
      onPressed: () async => await submitCallback(),
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(minimumWidth, minimumHeight),
          backgroundColor: MyTheme.submitColor),
      child: const Text(
        "Salvar",
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  static Widget cancelButton({required Function popCallback}) {
    return ElevatedButton(
      onPressed: () => popCallback(),
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(minimumWidth, minimumHeight),
          backgroundColor: MyTheme.cancelColor),
      child: const Text("Cancelar", style: TextStyle(fontSize: fontSize)),
    );
  }
}
