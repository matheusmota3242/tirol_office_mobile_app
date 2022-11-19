import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';
import 'package:tirol_office_mobile_app/view/screen/department/department_form_screen.dart';
import 'package:tirol_office_mobile_app/view/screen/equipment/equipment_screen.dart';
import 'package:tirol_office_mobile_app/view/widget/dialogs.dart';
import 'package:tirol_office_mobile_app/view/widget/utils_widget.dart';

import '../../../model/department.dart';
import '../../../service/department_service.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen(
      {Key? key, required this.serviceUnitId, required this.serviceUnitName})
      : super(key: key);

  final String serviceUnitId;
  final String serviceUnitName;

  @override
  Widget build(BuildContext context) {
    final _service = DepartmentService();

    const editOption = "Editar";
    const removeOption = "Remover";

    Future pushToDepartmentFormScreen(Department department) async {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DepartmentFormScreen(
                department: department,
              )));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("DEPARTAMENTOS"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DepartmentFormScreen(
                    department:
                        Department.defaultInitialization(serviceUnitId)))),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text(
              serviceUnitName,
              style: MyTheme.listTileTitleStyle,
            ),
            leading: const Icon(Icons.home),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width - 48,
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: StreamBuilder(
                stream: DepartmentService.collection
                    .where('serviceUnitId', isEqualTo: serviceUnitId)
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return UtilsWidget.connectionFailed;
                    case ConnectionState.active:
                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        List<Department>? departments = snapshot.data!.docs
                            .map((doc) =>
                                Department.fromJson(doc.data(), doc.id))
                            .toList();
                        return ListView.builder(
                            itemCount: departments.length,
                            itemBuilder: ((context, index) => ListTile(
                                  title: Text(
                                    departments[index].name,
                                    style: MyTheme.listTileTitleStyle,
                                  ),
                                  leading:
                                      const Icon(Icons.door_front_door_rounded),
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
                                          await pushToDepartmentFormScreen(
                                              departments[index]);
                                        } else if (result == removeOption) {
                                          Dialogs.deleteDialog(
                                              context,
                                              departments[index].name,
                                              _service.remove,
                                              departments[index].id);
                                        }
                                      }),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EquipmentScreen(
                                              departmentId:
                                                  departments[index].id,
                                              departmentName:
                                                  departments[index].name))),
                                )));
                      } else {
                        return UtilsWidget.noData;
                      }
                    case ConnectionState.waiting:
                      return UtilsWidget.loading;
                    default:
                      return UtilsWidget.unexpectedBehavior;
                  }
                }),
          ),
        ],
      ),
    );
  }
}
