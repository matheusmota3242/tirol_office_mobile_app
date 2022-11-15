import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/model/service_unit.dart';
import 'package:tirol_office_mobile_app/service/service_unit_service.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/view/screen/department/department_screen.dart';
import 'package:tirol_office_mobile_app/view/screen/service_unit/service_unit_form.dart';
import 'package:tirol_office_mobile_app/view/widget/dialogs.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

class ServiceUnitScreen extends StatelessWidget {
  const ServiceUnitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = ServiceUnitService();

    const editOption = "Editar";
    const removeOption = "Remover";

    pushToServiceUnitEditFormScreen({required ServiceUnit serviceUnit}) async {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ServiceUnitFormScreen(
                serviceUnit: serviceUnit,
              )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("UNIDADES"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ServiceUnitFormScreen(
                      serviceUnit: ServiceUnit.defaultInitialization(),
                    ))),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
          stream: ServiceUnitService.collection.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return UtilsWidget.connectionFailed;
              case ConnectionState.active:
                if (snapshot.hasData && snapshot.data!.size > 0) {
                  List<ServiceUnit>? units = snapshot.data?.docs
                      .map((doc) => ServiceUnit.fromJson(doc.data(), doc.id))
                      .toList();
                  return ListView.builder(
                      itemCount: units?.length,
                      itemBuilder: (context, index) => ListTile(
                          title: ListTile(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DepartmentScreen(
                                            serviceUnitId: units[index].id,
                                            serviceUnitName: units[index].name,
                                          ))),
                              leading: const Icon(Icons.house),
                              title: Text(
                                units![index].name,
                                style: MyTheme.listTileTitleStyle,
                              ),
                              subtitle: Text(
                                '${units[index].district}, ${units[index].address}, ${units[index].number}',
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                      value: editOption,
                                      child: Text(editOption)),
                                  const PopupMenuItem(
                                      value: removeOption,
                                      child: Text(removeOption))
                                ],
                                onSelected: (result) async {
                                  if (result == editOption) {
                                    await pushToServiceUnitEditFormScreen(
                                        serviceUnit: units[index]);
                                  } else if (result == removeOption) {
                                    Dialogs.deleteDialog(
                                        context,
                                        units[index].name,
                                        service.remove,
                                        units[index].id);
                                  }
                                },
                              ))));
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
