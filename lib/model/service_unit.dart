class ServiceUnit {
  late String id;
  late String name;
  late String address;
  late String district;
  late int number;

  ServiceUnit.defaultInitialization() {
    name = "";
    address = "";
    district = "";
    number = 0;
  }

  ServiceUnit.withParameters(
      {required this.id,
      required this.name,
      required this.address,
      required this.district,
      required this.number});

  ServiceUnit.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        address = json['address'],
        district = json['district'],
        number = json['number'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'district': district,
        'number': number
      };
}
