import 'dart:convert';

class NotificationDetailsModel {
  final String? id;
  final String? title;
  final String? receiverId;
  final String? role;
  final String? linkId;
  final String? notificationFor;
  final bool? viewStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationDetailsModel({
    this.id,
    this.title,
    this.receiverId,
    this.role,
    this.linkId,
    this.notificationFor,
    this.viewStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationDetailsModel.fromRawJson(String str) => NotificationDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationDetailsModel.fromJson(Map<String, dynamic> json) => NotificationDetailsModel(
    id: json["_id"],
    title: json["title"],
    receiverId: json["receiverId"],
    role: json["role"],
    linkId: json["linkId"],
    notificationFor: json["notificationFor"],
    viewStatus: json["viewStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "receiverId": receiverId,
    "role": role,
    "linkId": linkId,
    "notificationFor": notificationFor,
    "viewStatus": viewStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
