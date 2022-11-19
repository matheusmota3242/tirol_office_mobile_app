import 'package:flutter/material.dart';
import 'package:tirol_office_mobile_app/theme/theme.dart';

import '../../../model/equipment.dart';
import '../../../service/equipment_service.dart';
import '../../../utils/constants.dart';
import '../../widget/dialogs.dart';
import '../../widget/utils_widget.dart';
import 'equipment_form_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen(
      {Key? key, required this.departmentId, required this.departmentName})
      : super(key: key);

  final String departmentId;
  final String departmentName;

  @override
  Widget build(BuildContext context) {
    var _service = EquipmentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("EQUIPAMENTOS"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EquipmentFormScreen(
                    equipment: Equipment.defaultInitialization(departmentId)))),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
          stream: EquipmentService.collection
              .where('departmentId', isEqualTo: departmentId)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return UtilsWidget.connectionFailed;
              case ConnectionState.active:
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  List<Equipment>? equipments = snapshot.data!.docs
                      .map((doc) => Equipment.fromJson(doc.data(), doc.id))
                      .toList();
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          departmentName,
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
                        child: ListView.builder(
                            itemCount: equipments.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(equipments[index].name,
                                      style: MyTheme.listTileTitleStyle),
                                  subtitle:
                                      Text(equipments[index].observations),
                                  leading: const Icon(Icons.settings),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                          value: Constants.editOpionText,
                                          child: Text(Constants.editOpionText)),
                                      const PopupMenuItem(
                                          value: Constants.removeOpionText,
                                          child:
                                              Text(Constants.removeOpionText))
                                    ],
                                    onSelected: (result) {
                                      if (Constants.editOpionText == result) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EquipmentFormScreen(
                                                        equipment: equipments[
                                                            index])));
                                      } else if (Constants.removeOpionText ==
                                          result) {
                                        Dialogs.deleteDialog(
                                            context,
                                            equipments[index].name,
                                            _service.remove,
                                            equipments[index].id);
                                      }
                                    },
                                  ),
                                )),
                      ),
                    ],
                  );
                } else {
                  return UtilsWidget.noData;
                }
              default:
                return UtilsWidget.unexpectedBehavior;
            }
          }),
    );
  }
}
