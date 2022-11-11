import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/buttons.dart';

class Dialogs {
  static deleteDialog(BuildContext context, String name) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Remover", style: TextStyle(color: Colors.red)),
              content: Text("Tem certeza que deseja remover $name?"),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actionsPadding: const EdgeInsets.symmetric(vertical: 18.0),
              actions: [
                Buttons.cancelButton(popCallback: Navigator.of(context).pop),
                Buttons.submitButton(submitCallback: () {})
              ],
            ));
  }
}
