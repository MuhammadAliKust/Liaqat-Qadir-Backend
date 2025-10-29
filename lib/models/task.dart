// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';


class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? image;
  final String? priorityID;
  final List<String>? favorite;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.favorite,
    this.priorityID,
    this.image,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docID"],
    title: json["title"],
    description: json["description"],
     favorite: json["favorite"] == null ? [] : List<String>.from(json["favorite"]!.map((x) => x)),
 
    priorityID: json["priorityID"],
    image: json["image"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docID": taskID,
    "title": title,
    "description": description,
    "priorityID": priorityID,
    "image": image,
    "isCompleted": isCompleted,
     "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
 
    "createdAt": createdAt,
  };
}
