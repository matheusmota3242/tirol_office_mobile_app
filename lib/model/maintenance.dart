class Maintenance {
  late String id;
  late DateTime dateTime;
  late bool occured;
  late String problemDescription;
  late String solutionDescription;
  late String equipmentId;
  late String serviceProviderId;
  late String departmentId;
  late String serviceUnitId;

  Maintenance.defaultInitialization(
      this.equipmentId, this.departmentId, this.serviceUnitId)
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
        equipmentId = json['equipmentId'],
        serviceProviderId = json['serviceProviderId'],
        departmentId = json['departmentId'],
        serviceUnitId = json['serviceUnitId'];

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'occured': occured,
        'solutionDescription': solutionDescription,
        'problemDescription': problemDescription,
        'equipmentId': equipmentId,
        'serviceProviderId': serviceProviderId,
        'departmentId': departmentId,
        'serviceUnitId': serviceUnitId
      };
}
