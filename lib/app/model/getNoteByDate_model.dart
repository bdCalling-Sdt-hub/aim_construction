import 'dart:convert';

class GetAllNoteByDateModel {
  final String? id;
  final String? title;
  final String? description;
  final String? isAccepted;
  final DateTime? createdAt;
  final int? imageCount;
  final int? documentCount;
  final int? totalNoteCount;

  GetAllNoteByDateModel({
    this.id,
    this.title,
    this.description,
    this.isAccepted,
    this.createdAt,
    this.imageCount,
    this.documentCount,
    this.totalNoteCount,
  });

  factory GetAllNoteByDateModel.fromRawJson(String str) => GetAllNoteByDateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllNoteByDateModel.fromJson(Map<String, dynamic> json) => GetAllNoteByDateModel(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    isAccepted: json["isAccepted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    imageCount: json["imageCount"],
    documentCount: json["documentCount"],
    totalNoteCount: json["totalNoteCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "isAccepted": isAccepted,
    "createdAt": createdAt?.toIso8601String(),
    "imageCount": imageCount,
    "documentCount": documentCount,
    "totalNoteCount": totalNoteCount,
  };
}
