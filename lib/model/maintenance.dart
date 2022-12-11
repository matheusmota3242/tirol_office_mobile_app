class Maintenance {
  late String id;
  late DateTime dateTime;
  late bool occured;
  late String problemDescription;
  late String solutionDescription;
  late String equipmentName;
  late String serviceProviderName;
  late String departmentName;
  late String serviceUnitName;

  Maintenance.defaultInitialization(
      this.equipmentName, this.departmentName, this.serviceUnitName)
      : id = '',
        dateTime = DateTime.now(),
        occured = false,
        problemDescription = '',
        solutionDescription = '';

  Maintenance.fromJson(Map<String, dynamic> json, this.id)
      : dateTime = json['dateTime'],
        occured = json['occured'],
        problemDescription = json['problemDescription'],
        solutionDescription = json['solutionDescription'],
        equipmentName = json['equipmentName'],
        serviceProviderName = json['serviceProviderName'],
        departmentName = json['departmentName'],
        serviceUnitName = json['serviceUnitName'];

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'occured': occured,
        'solutionDescription': solutionDescription,
        'problemDescription': problemDescription,
        'equipmenName': equipmentName,
        'serviceProviderName': serviceProviderName,
        'departmentName': departmentName,
        'serviceUnitName': serviceUnitName
      };
}
