import 'dart:convert';

class GetTaskDetailByIdModel {
  final String? taskStatus;
  final AssignedTo? assignedTo;
  final String? projectId;
  final DateTime? dueDate;
  final String? title;
  final String? description;
  final String? createdBy;
  final List<Attachment>? attachments;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? taskId;

  GetTaskDetailByIdModel({
    this.taskStatus,
    this.assignedTo,
    this.projectId,
    this.dueDate,
    this.title,
    this.description,
    this.createdBy,
    this.attachments,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.taskId,
  });

  factory GetTaskDetailByIdModel.fromRawJson(String str) => GetTaskDetailByIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTaskDetailByIdModel.fromJson(Map<String, dynamic> json) => GetTaskDetailByIdModel(
    taskStatus: json["task_status"],
    assignedTo: json["assignedTo"] == null ? null : AssignedTo.fromJson(json["assignedTo"]),
    projectId: json["projectId"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    title: json["title"],
    description: json["description"],
    createdBy: json["createdBy"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    taskId: json["_taskId"],
  );

  Map<String, dynamic> toJson() => {
    "task_status": taskStatus,
    "assignedTo": assignedTo?.toJson(),
    "projectId": projectId,
    "dueDate": dueDate?.toIso8601String(),
    "title": title,
    "description": description,
    "createdBy": createdBy,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "_taskId": taskId,
  };
}

class AssignedTo {
  final String? fname;
  final String? lname;
  final String? superVisorsManagerId;
  final String? userId;

  AssignedTo({
    this.fname,
    this.lname,
    this.superVisorsManagerId,
    this.userId,
  });

  factory AssignedTo.fromRawJson(String str) => AssignedTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
    fname: json["fname"],
    lname: json["lname"],
    superVisorsManagerId: json["superVisorsManagerId"],
    userId: json["_userId"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "superVisorsManagerId": superVisorsManagerId,
    "_userId": userId,
  };
}

class Attachment {
  final String? attachment;
  final String? attachmentType;
  final String? projectId;
  final DateTime? createdAt;
  final String? attachmentId;

  Attachment({
    this.attachment,
    this.attachmentType,
    this.projectId,
    this.createdAt,
    this.attachmentId,
  });

  factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachment: json["attachment"],
    attachmentType: json["attachmentType"],
    projectId: json["projectId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    attachmentId: json["_attachmentId"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "attachmentType": attachmentType,
    "projectId": projectId,
    "createdAt": createdAt?.toIso8601String(),
    "_attachmentId": attachmentId,
  };
}
