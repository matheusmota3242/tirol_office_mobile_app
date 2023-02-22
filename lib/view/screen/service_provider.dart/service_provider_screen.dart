import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/service/service_provider_service.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/view/screen/service_provider.dart/service_provider_form_screen.dart';
import 'package:tirol_office_mobile_app/view/widget/dialogs.dart';
import 'package:tirol_office_mobile_app/view/widget/drawer.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../model/service_provider.dart';

class ServiceProviderScreen extends StatelessWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = ServiceProviderService();
    const screenTitle = 'PRESTADORES DE SERVIÇO';

    const editOption = "Editar";
    const removeOption = "Remover";

    return Scaffold(
      appBar: AppBar(
        title: const Text(screenTitle),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            // onPressed: () {},
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ServiceProviderFormScreen(
                    serviceProvider: ServiceProvider.defaultInitialization()))),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: MyDrawer.drawer(context, screenTitle),
      body: StreamBuilder(
          stream: ServiceProviderService.collection
              .where('active', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return UtilsWidget.connectionFailed;
              case ConnectionState.active:
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<ServiceProvider>? serviceProviders = snapshot.data!.docs
                      .map(
                          (doc) => ServiceProvider.fromJson(doc.data(), doc.id))
                      .toList();
                  return ListView.builder(
                    itemCount: serviceProviders.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(serviceProviders[index].name,
                          style: MyTheme.listTileTitleStyle),
                      subtitle: SelectableText(
                          '\n${serviceProviders[index].description}\n\nTelefone: ${serviceProviders[index].phone}\n\nEmail: ${serviceProviders[index].email}'),
                      contentPadding: const EdgeInsets.all(24),
                      leading: const Icon(Icons.business_center),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: editOption,
                            child: Text(editOption),
                          ),
                          const PopupMenuItem(
                              value: removeOption, child: Text(removeOption))
                        ],
                        onSelected: (value) async {
                          if (editOption == value) {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    ServiceProviderFormScreen(
                                        serviceProvider:
                                            serviceProviders[index]))));
                          } else {
                            Dialogs.deleteDialog(
                                context,
                                serviceProviders[index].name,
                                service.remove,
                                serviceProviders[index].id);
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  return UtilsWidget.noData;
                }
              case ConnectionState.waiting:
                return UtilsWidget.loading;
              default:
                return UtilsWidget.unexpectedBehavior;
            }
          }),
    );
  }
}
