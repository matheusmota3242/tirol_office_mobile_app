import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/view/screen/service_unit/service_unit_screen.dart';

import 'package:tirol_office_mobile_app/view/widget/buttons.dart';

import '../../../service/service_unit_service.dart';
import '../../widget/fields.dart';

class ServiceUnitFormScreen extends StatefulWidget {
  const ServiceUnitFormScreen({Key? key, required this.serviceUnit})
      : super(key: key);

  final ServiceUnit serviceUnit;

  @override
  State<StatefulWidget> createState() => _ServiceUnitFormScreenState();
}

final _formKey = GlobalKey<FormState>();
final _service = ServiceUnitService();

class _ServiceUnitFormScreenState extends State<ServiceUnitFormScreen> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var districtController = TextEditingController();
  var numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.serviceUnit.name;
    addressController.text = widget.serviceUnit.address;
    districtController.text = widget.serviceUnit.district;
    numberController.text = widget.serviceUnit.number == 0
        ? ""
        : widget.serviceUnit.number.toString();
  }

  @override
  Widget build(BuildContext context) {
    submit() async {
      var navigator = Navigator.of(context);
      if (_formKey.currentState!.validate()) {
        try {
          ServiceUnit serviceUnit = ServiceUnit.withParameters(
              id: widget.serviceUnit.id,
              name: nameController.text.trim(),
              address: addressController.text.trim(),
              district: districtController.text.trim(),
              number: int.parse(numberController.text.trim()));
          await _service.save(serviceUnit);
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Erro ao tentar salvar unidade.",
              gravity: ToastGravity.CENTER);
          print(e);
        }
        await navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ServiceUnitScreen()),
            (route) => false);
      }
    }

    getTitle() =>
        widget.serviceUnit.name == "" ? "NOVA UNIDADE" : "EDITAR UNIDADE";

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
              Fields.getTextFormField(nameController, "Nome"),
              Fields.getTextFormField(addressController, "Logradouro"),
              Fields.getTextFormField(districtController, "Bairro"),
              Fields.getNumberFormField(numberController, "Número"),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons.cancelButton(popCallback: Navigator.of(context).pop),
                  Buttons.submitButton(submitCallback: submit)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
