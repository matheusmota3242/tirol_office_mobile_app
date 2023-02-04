class ServiceProvider {
  late String id;
  late String name;
  late String description;
  late String email;
  late String phone;
  late bool active;

  ServiceProvider.defaultInitialization()
      : id = '',
        name = '',
        description = '',
        email = '',
        phone = '',
        active = true;

  ServiceProvider.fromJson(Map<String, dynamic> json, this.id)
      : name = json['name'],
        description = json['description'],
        email = json['email'],
        phone = json['phone'],
        active = json['active'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'email': email,
        'phone': phone,
        'active': active
      };
}
