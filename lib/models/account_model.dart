import 'package:cloud_firestore/cloud_firestore.dart';

 class Account {
  final String name;
  final String password;
  final String type;
  final String description;
  final String website;

  Account({
    required this.name,
    required this.password,
    required this.type,
    required this.description,
    required this.website,
    });

  Map<String, dynamic> toJson() => {
    'name': name,
    'password': password,
    'type': type,
    'description': description,
    'website': website,
  };

  static Account fromJson(Map<String, dynamic> json) => Account(
    name: json['name'],
    password: json['password'],
    type: json['type'],
    description: json['description'],
    website: json['website']
  );
}