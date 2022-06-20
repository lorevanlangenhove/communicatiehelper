import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  String id;
  final String title;
  String description;
  final DateTime from;
  final DateTime to;
  final Color eventColor;
  final bool isAllDay;

  Event(
      {this.id = '',
      required this.title,
      this.description = '',
      required this.from,
      required this.to,
      this.eventColor = Colors.red,
      this.isAllDay = false});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'from': from,
        'to': to,
      };

  static Event fromJson(Map<String, dynamic> json) => Event(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        from: (json['from'] as Timestamp).toDate(),
        to: (json['to'] as Timestamp).toDate(),
      );
}
