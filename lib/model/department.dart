class Department {
  late String id;
  late String name;
  late String serviceUnitId;
  late bool active;

  Department(this.id, this.name, this.serviceUnitId);

  Department.defaultInitialization(this.serviceUnitId)
      : id = "",
        name = "",
        active = true;

  Department.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        serviceUnitId = json['serviceUnitId'],
        active = json['active'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'serviceUnitId': serviceUnitId, 'active': true};
}
