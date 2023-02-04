// ignore_for_file: unused_catch_stack, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:tirol_office_mobile_app/exception/bad_form_exception.dart';
import 'package:tirol_office_mobile_app/mobx/error_boolean/error_boolean_mobx.dart';
import 'package:tirol_office_mobile_app/mobx/loading/loading_mobx.dart';
import 'package:tirol_office_mobile_app/service/service_provider_service.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/view/widget/dialogs.dart';
import 'package:tirol_office_mobile_app/view/widget/fields.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../model/maintenance.dart';
import '../../../model/service_provider.dart';
import '../../../service/maintenance_service.dart';
import '../../../utils/utils.dart';
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

  var serviceProviders = <ServiceProvider>[];

  var dateController = TextEditingController();
  var problemDescriptionController = TextEditingController();
  var solutionDescriptionController = TextEditingController();
  final serviceProviderDropdownHintMessage = 'Selecione o provedor de serviço*';
  //var serviceProviderDropdown = ServiceProviderDropdown();

  var errorBooleanMobx = ErrorBoolean();
  var loadingMobx = LoadingMobx();

  final serviceProvidersErrorMessage =
      "Erro ao carregar os provedores de serviço.";
  final emptyServiceProvidersMessage =
      "Não há provedores de serviço cadastrados. Primeiro cadastre um provedor de serviço.";
  String selectedServiceProvider = '';

  String getTitle() =>
      widget.maintenance.id.isEmpty ? 'NOVA MANUTENÇÃO' : 'EDITAR MANUTENÇÃO';

  handleMaintenanceFormData() {
    if (selectedServiceProvider.isNotEmpty) {
      attributeValuesToMaintenance();
    } else {
      Dialogs.regularDialog(
          context, 'Formulário inválido', 'Selecione um provedor de serviço.');
      throw BadFormException();
    }
  }

  void attributeValuesToMaintenance() {
    widget.maintenance.dateTime = DateTime.parse(
        '${dateController.text.substring(6, 10)}-${dateController.text.substring(3, 5)}-${dateController.text.substring(0, 2)}');
    widget.maintenance.problemDescription = problemDescriptionController.text;
    widget.maintenance.solutionDescription =
        widget.maintenance.id.isEmpty ? '' : solutionDescriptionController.text;
    widget.maintenance.serviceProviderId = serviceProviders
        .firstWhere((sp) => sp.name == selectedServiceProvider)
        .id;
  }

  Future _submit() async {
    var navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      try {
        handleMaintenanceFormData();
        await _service.save(widget.maintenance);

        if (!mounted) return;
        SnackBars.showSnackBar(context, "Departamento salvo com sucesso.");
      } on BadFormException {
        return;
      } catch (e) {
        SnackBars.showSnackBar(context, "Erro ao salvar departamento.");
      }
      navigator.pop();
    }
  }

  @override
  initState() {
    dateController.text =
        DateFormat('dd/MM/yyyy').format(widget.maintenance.dateTime);
    problemDescriptionController.text = widget.maintenance.problemDescription;
    solutionDescriptionController.text = widget.maintenance.solutionDescription;

    _getServiceProviders();

    super.initState();
  }

  _getServiceProviders() async {
    loadingMobx.setLoading(true);
    var query = await ServiceProviderService.collection
        .where('active', isEqualTo: true)
        .get();
    if (query.docs.isNotEmpty) {
      setState(() {
        serviceProviders = query.docs
            .map((doc) => ServiceProvider.fromJson(doc.data(), doc.id))
            .toList();
        selectedServiceProvider = serviceProviders[0].name;
      });
    } else {
      errorBooleanMobx.setError(true);
    }
    loadingMobx.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    showServiceProviderDropdown() {
      if (serviceProviders.isNotEmpty) {
        errorBooleanMobx.setError(false);
        return DropdownButtonFormField(
            value: serviceProviders[0].name,
            decoration: const InputDecoration(
              labelText: 'Provedores de serviço',
              labelStyle: MyTheme.labelStyle,
              filled: true,
              prefixIcon: Icon(Icons.business_center),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            items: serviceProviders
                .map((sp) => DropdownMenuItem(
                      value: sp.name,
                      child: Text(sp.name),
                    ))
                .toList(),
            onChanged: (value) => selectedServiceProvider = value!);
      } else {
        errorBooleanMobx.setError(true);
        return Column(
          children: [
            Row(
              children: const [
                Icon(Icons.warning),
                SizedBox(
                  width: 12.0,
                ),
                Flexible(
                  child: Text(
                    'Não há provedores de serviço cadastrados. Por favor, cadastre um e retorne.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        );
      }
    }

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
            child: Observer(builder: (context) {
              if (loadingMobx.loading) {
                return UtilsWidget.loading;
              } else {
                return ListView(
                  children: [
                    showServiceProviderDropdown(),
                    const SizedBox(height: 24.0),
                    dateField(),
                    const SizedBox(height: 24.0),
                    Fields.getTextFormWithMultipleLinesField(
                        problemDescriptionController, 'Descrição*', 3),
                    const SizedBox(height: 24.0),
                    Visibility(
                        visible: widget.maintenance.id.isEmpty &&
                                widget.maintenance.occured
                            ? false
                            : true,
                        child: Fields.getTextFormWithMultipleLinesField(
                            solutionDescriptionController, "Solução*", 3)),
                    const SizedBox(
                      height: 24,
                    ),
                    Visibility(
                      visible: Utils.isTodayAfterDateTime(
                          widget.maintenance.dateTime),
                      child: CheckboxListTile(
                          title: const Text(
                            'Status',
                            style: MyTheme.listTileTitleStyle,
                          ),
                          value: widget.maintenance.occured,
                          onChanged: (value) {
                            setState(() {
                              widget.maintenance.occured = value!;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Buttons.cancelButton(
                            popCallback: () => Navigator.of(context).pop),
                        Observer(builder: (_) {
                          return Buttons.submitEnablableButton(
                              submitCallback: _submit,
                              isEnable: !errorBooleanMobx.error);
                        })
                      ],
                    )
                  ],
                );
              }
            }),
          )),
    );
  }

  dateField() => TextFormField(
        decoration: const InputDecoration(
          filled: true,
          labelText: 'Data*',
          labelStyle: MyTheme.labelStyle,
          prefixIcon: Icon(Icons.calendar_today),
          counterStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? "Campo obrigatório" : null,
        controller: dateController,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2050));
          if (pickedDate != null) {
            setState(() {
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          }
        },
      );
}
