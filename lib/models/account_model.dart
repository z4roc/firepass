 class Account {
  String id;
  final String name;
  final String password;
  final String type;
  final String description;
  final String website;

  Account({
    this.id = '',
    required this.name,
    required this.password,
    required this.type,
    required this.description,
    required this.website,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'password': password,
    'type': type,
    'description': description,
    'website': website,
  };

  static Account fromJson(Map<String, dynamic> json) => Account(
    id: json['id'],
    name: json['name'],
    password: json['password'],
    type: json['type'],
    description: json['description'],
    website: json['website']
  );
}