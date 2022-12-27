import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/service/service_provider_service.dart';
import 'package:tirol_office_mobile_app/view/screen/service_provider.dart/service_provider_form_screen.dart';
import 'package:tirol_office_mobile_app/view/widget/drawer.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../model/service_provider.dart';

class ServiceProviderScreen extends StatelessWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screenTitle = 'PROVEDORES DE SERVIÇO';
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
          stream: ServiceProviderService.collection.snapshots(),
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
                      title: Text(serviceProviders[index].name),
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
