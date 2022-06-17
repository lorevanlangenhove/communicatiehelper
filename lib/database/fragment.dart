import 'package:cloud_firestore/cloud_firestore.dart';

class Fragment {
  String id;
  final String title;
  String description;
  DateTime created;

  Fragment(
      {this.id = '',
      required this.title,
      this.description = '',
      required this.created});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'created': created,
      };

  static Fragment fromJson(Map<String, dynamic> json) => Fragment(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        created: (json['created'] as Timestamp).toDate(),
      );
}
