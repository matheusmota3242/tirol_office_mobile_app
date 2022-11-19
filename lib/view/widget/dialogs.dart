import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/buttons.dart';
import 'package:tirol_office_mobile_app/view/widget/snackbars.dart';

class Dialogs {
  static deleteDialog(
      BuildContext context, String name, Function removeCallback, String id) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Remover", style: TextStyle(color: Colors.red)),
              content: Text("Tem certeza que deseja remover $name?"),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actionsPadding: const EdgeInsets.symmetric(vertical: 18.0),
              actions: [
                Buttons.cancelButton(popCallback: Navigator.of(context).pop),
                Buttons.submitButton(submitCallback: () {
                  try {
                    removeCallback(id);
                    SnackBars.showSnackBar(
                        context, 'Item removido com sucesso.');
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                  }
                }),
              ],
            ));
  }
}
