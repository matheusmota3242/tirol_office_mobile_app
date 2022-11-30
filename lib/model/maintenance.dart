class Maintenance {
  late String id;
  late DateTime dateTime;
  late bool occured;
  late String description;
  late String equipmentName;
  late String serviceProviderName;
  late String departmentName;
  late String serviceUnitName;

  Maintenance.fromJson(Map<String, dynamic> json, this.id)
      : dateTime = json['dateTime'],
        occured = json['occured'],
        description = json['description'],
        equipmentName = json['equipmentName'],
        serviceProviderName = json['serviceProviderName'],
        departmentName = json['departmentName'],
        serviceUnitName = json['serviceUnitName'];

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'occured': occured,
        'description': description,
        'equipmenName': equipmentName,
        'serviceProviderName': serviceProviderName,
        'departmentName': departmentName,
        'serviceUnitName': serviceUnitName
      };
}
