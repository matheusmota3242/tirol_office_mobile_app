import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tirol_office_mobile_app/view/widget/fields.dart';

import '../../../model/maintenance.dart';
import '../../../service/maintenance_service.dart';
import '../../widget/buttons.dart';
import '../../widget/snackbars.dart';

class MaintenanceFormScreen extends StatefulWidget {
  const MaintenanceFormScreen({Key? key, required this.maintenance})
      : super(key: key);

  final Maintenance maintenance;
  @override
  MaintenanceFormScreenState createState() => MaintenanceFormScreenState();
}

class MaintenanceFormScreenState extends State<MaintenanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = MaintenanceService();

  var dateController = TextEditingController();
  var problemDescriptionController = TextEditingController();

  String getTitle() =>
      widget.maintenance.id.isEmpty ? 'NOVA MANUTENÇÃO' : 'EDITAR MANUTENÇÃO';

  Future _submit() async {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        widget.maintenance.dateTime = DateTime.parse(
            '${dateController.text.substring(6, 10)}-${dateController.text.substring(3, 5)}-${dateController.text.substring(0, 2)}');
        widget.maintenance.problemDescription =
            problemDescriptionController.text;
        await _service.save(widget.maintenance);

        if (!mounted) return;
        SnackBars.showSnackBar(context, "Departamento salvo com sucesso.");
      } catch (e) {
        SnackBars.showSnackBar(context, "Erro ao salvar departamento.");
        print(e);
      }
      navigator.pop();
    }
  }

  @override
  void initState() {
    dateController.text =
        DateFormat('dd/MM/yyyy').format(widget.maintenance.dateTime);
    problemDescriptionController.text = widget.maintenance.problemDescription;
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('Data',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.calendar_today)
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          counterStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Campo obrigatório" : null,
                        controller: dateController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050));
                          if (pickedDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  Fields.getTextFormWithMultipleLinesField(
                      problemDescriptionController, 'Descrição do problema', 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Buttons.cancelButton(
                          popCallback: () => Navigator.of(context).pop),
                      Buttons.submitButton(submitCallback: _submit)
                    ],
                  )
                ],
              ))),
    );
  }
}
