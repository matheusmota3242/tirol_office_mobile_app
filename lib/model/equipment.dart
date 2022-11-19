class Equipment {
  late String id;
  late String name;
  late String observations;
  late String departmentId;

  Equipment.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        observations = json['observations'],
        departmentId = json['departmentId'];

  Equipment.defaultInitialization(this.departmentId)
      : id = "",
        name = "",
        observations = "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'observations': observations,
        'departmentId': departmentId
      };
}
