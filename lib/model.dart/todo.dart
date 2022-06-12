import 'package:flutter/material.dart';

import '../utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;
  String imageUrl;

  Todo(
      {required this.createdTime,
      required this.title,
      this.description = '',
      required this.id,
      this.isDone = false,
      this.imageUrl = ''});

  static Todo fromJson(Map<String, dynamic> json) => Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      imageUrl: json['imageUrl']);

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'imageUrl': imageUrl
      };
}
