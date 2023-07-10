// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(
        json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel {
  int userId;
  int id;
  String title;
  String body;

  QuestionModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  QuestionModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      QuestionModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
