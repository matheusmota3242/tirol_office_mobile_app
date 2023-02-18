import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/model/service_provider.dart';
import 'package:tirol_office_mobile_app/service/service_provider_service.dart';
import 'package:tirol_office_mobile_app/view/widget/fields.dart';

import '../../widget/buttons.dart';
import '../../widget/snackbars.dart';

class ServiceProviderFormScreen extends StatefulWidget {
  const ServiceProviderFormScreen({Key? key, required this.serviceProvider})
      : super(key: key);

  final ServiceProvider serviceProvider;

  @override
  ServiceProviderFormScreenState createState() =>
      ServiceProviderFormScreenState();
}

class ServiceProviderFormScreenState extends State<ServiceProviderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = ServiceProviderService();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String getTitle() => widget.serviceProvider.id.isEmpty
      ? 'NOVO PROVEDOR DE SERVIÇO'
      : 'EDITAR PROVEDOR DE SERVIÇO';

  @override
  void initState() {
    _nameController.text = widget.serviceProvider.name;
    _descriptionController.text = widget.serviceProvider.description;
    _phoneController.text = widget.serviceProvider.phone;
    _emailController.text = widget.serviceProvider.email;
    super.initState();
  }

  Future _submit() async {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        widget.serviceProvider.name = _nameController.text;
        widget.serviceProvider.description = _descriptionController.text;
        widget.serviceProvider.email = _emailController.text;
        widget.serviceProvider.phone = _phoneController.text;
        await _service.save(widget.serviceProvider);

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
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Fields.getTextFormField(_nameController, "Nome*", true),
                const SizedBox(
                  height: 24,
                ),
                Fields.getTextFormField(
                    _descriptionController, "Descrição*", true),
                const SizedBox(
                  height: 24,
                ),
                Fields.getPhoneNumberFormField(
                    _phoneController, "Telefone*", true),
                const SizedBox(
                  height: 24,
                ),
                Fields.getEmailTextFormField(_emailController, "E-mail*", true),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Buttons.cancelButton(
                        popCallback: Navigator.of(context).pop),
                    Buttons.submitButton(submitCallback: _submit)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
