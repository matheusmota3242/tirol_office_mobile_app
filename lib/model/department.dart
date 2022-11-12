class Department {
  late String id;
  late String name;
  late String serviceUnitId;

  Department.defaultInitialization(this.serviceUnitId) {
    id = "";
    name = "";
  }

  Department.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        serviceUnitId = json['serviceUnitId'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'serviceUnitId': serviceUnitId};
}
