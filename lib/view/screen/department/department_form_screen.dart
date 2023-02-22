import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/view/widget/snackbars.dart';

import '../../../model/department.dart';
import '../../../service/department_service.dart';
import '../../widget/buttons.dart';
import '../../widget/fields.dart';

class DepartmentFormScreen extends StatefulWidget {
  const DepartmentFormScreen({Key? key, required this.department})
      : super(key: key);
  final Department department;
  @override
  DepartmentFormScreenState createState() => DepartmentFormScreenState();
}

class DepartmentFormScreenState extends State<DepartmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = DepartmentService();

  var nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.department.name;
    super.initState();
  }

  String getTitle() => widget.department.id.isEmpty
      ? "NOVO DEPARTAMENTO"
      : "EDITAR DEPARTAMENTO";

  Future _submit() async {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        widget.department.name = nameController.text;
        await _service.save(widget.department);

        if (!mounted) return;
        SnackBars.showSnackBar(context, "Departamento salvo com sucesso.");
      } catch (e) {
        SnackBars.showSnackBar(context, "Erro ao salvar departamento.");
      }
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Fields.getTextFormField(nameController, 'Nome*', true),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Buttons.cancelButton(
                          popCallback: Navigator.of(context).pop),
                      Buttons.submitButton(submitCallback: _submit)
                    ],
                  )
                ],
              ))),
    );
  }
}
