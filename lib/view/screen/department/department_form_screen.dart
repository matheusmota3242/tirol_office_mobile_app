import 'package:flutter/material.dart';

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

  getTitle() => widget.department.id.isEmpty
      ? "NOVO DEPARTAMENTO"
      : "EDITAR DEPARTAMENTO";

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
                  Fields.getTextFormField(nameController, 'Nome'),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Buttons.cancelButton(
                          popCallback: Navigator.of(context).pop),
                      Buttons.submitButton(submitCallback: () {})
                    ],
                  )
                ],
              ))),
    );
  }
}
