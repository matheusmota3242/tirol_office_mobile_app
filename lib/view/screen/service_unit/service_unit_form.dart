import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/view/widget/buttons.dart';
import 'package:tirol_office_mobile_app/view/widget/snackbars.dart';

import '../../../service/service_unit_service.dart';
import '../../widget/fields.dart';
import '../../widget/paddings.dart';

class ServiceUnitFormScreen extends StatefulWidget {
  const ServiceUnitFormScreen({Key? key, required this.serviceUnit})
      : super(key: key);

  final ServiceUnit serviceUnit;

  @override
  State<StatefulWidget> createState() => _ServiceUnitFormScreenState();
}

class _ServiceUnitFormScreenState extends State<ServiceUnitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = ServiceUnitService();

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var districtController = TextEditingController();
  var numberController = TextEditingController();

  initControllers() {
    nameController.text = widget.serviceUnit.name;
    addressController.text = widget.serviceUnit.address;
    districtController.text = widget.serviceUnit.district;
    numberController.text = widget.serviceUnit.number == 0
        ? ""
        : widget.serviceUnit.number.toString();
  }

  @override
  void initState() {
    initControllers();
    super.initState();
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
          if (!mounted) return;
          SnackBars.showSnackBar(context, 'Unidade salva com sucesso.');
        } catch (e) {
          SnackBars.showSnackBar(context, 'Erro ao tentar salvar unidade.');
        }
        navigator.pop();
      }
    }

    getTitle() =>
        widget.serviceUnit.name.isEmpty ? "NOVA UNIDADE" : "EDITAR UNIDADE";

    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: Paddings.screenPadding,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 24,
              ),
              Fields.getTextFormField(nameController, "Nome*", true),
              const SizedBox(
                height: 24,
              ),
              Fields.getAddressTextFormField(
                  addressController, "Logradouro*", true),
              const SizedBox(
                height: 24,
              ),
              Fields.getAddressTextFormField(
                  districtController, "Bairro*", true),
              const SizedBox(
                height: 24,
              ),
              Fields.getAddressNumberFormField(
                  numberController, "Número*", true),
              const SizedBox(height: 50),
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
