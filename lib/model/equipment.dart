class Equipment {
  late String id;
  late String name;
  late String observations;
  late String departmentId;
  late bool active;

  Equipment.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        observations = json['observations'],
        departmentId = json['departmentId'],
        active = json['active'];

  Equipment.defaultInitialization(this.departmentId)
      : id = "",
        name = "",
        observations = "",
        active = true;

  Map<String, dynamic> toJson() => {
        'name': name,
        'observations': observations,
        'departmentId': departmentId,
        'active': true
      };
}
