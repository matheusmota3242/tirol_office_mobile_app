import 'package:flutter/material.dart';

import '../../../model/equipment.dart';
import '../../../service/equipment_service.dart';
import '../../widget/buttons.dart';
import '../../widget/fields.dart';
import '../../widget/snackbars.dart';

class EquipmentFormScreen extends StatefulWidget {
  const EquipmentFormScreen({Key? key, required this.equipment})
      : super(key: key);

  final Equipment equipment;

  @override
  EquipmentFormScreenState createState() => EquipmentFormScreenState();
}

class EquipmentFormScreenState extends State<EquipmentFormScreen> {
  final _service = EquipmentService();
  final _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var observationsController = TextEditingController();

  String getTitle() =>
      widget.equipment.id.isEmpty ? 'NOVO EQUIPAMENTO' : 'EDITAR EQUIPAMENTO';

  Future _submit() async {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        widget.equipment.name = nameController.text;
        widget.equipment.observations = observationsController.text;
        await _service.save(widget.equipment);

        if (!mounted) return;
        SnackBars.showSnackBar(context, "Equipamento salvo com sucesso.");
      } catch (e) {
        SnackBars.showSnackBar(context, "Erro ao salvar equipamento.");
      }
      navigator.pop();
    }
  }

  @override
  void initState() {
    nameController.text = widget.equipment.name;
    observationsController.text = widget.equipment.observations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Fields.getTextFormField(nameController, 'Nome'),
              const SizedBox(height: 24.0),
              Fields.getTextFormWithMultipleLinesField(
                  observationsController, 'Observações', 5),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons.cancelButton(popCallback: Navigator.of(context).pop),
                  Buttons.submitButton(submitCallback: _submit)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
