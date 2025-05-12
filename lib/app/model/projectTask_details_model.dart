import 'dart:convert';

class ProjectTaskDetailsModel {
  final String? id;
  final String? taskStatus;
  final AssignedTo? assignedTo;
  final String? projectId;
  final DateTime? dueDate;
  final String? title;
  final String? description;
  final String? createdBy;
  final List<Attachment>? attachments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? imageCount;
  final int? documentCount;

  ProjectTaskDetailsModel({
    this.id,
    this.taskStatus,
    this.assignedTo,
    this.projectId,
    this.dueDate,
    this.title,
    this.description,
    this.createdBy,
    this.attachments,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.imageCount,
    this.documentCount,
  });

  factory ProjectTaskDetailsModel.fromRawJson(String str) => ProjectTaskDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectTaskDetailsModel.fromJson(Map<String, dynamic> json) => ProjectTaskDetailsModel(
    id: json["_id"],
    taskStatus: json["task_status"],
    assignedTo: json["assignedTo"] == null ? null : AssignedTo.fromJson(json["assignedTo"]),
    projectId: json["projectId"],
    dueDate: json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
    title: json["title"],
    description: json["description"],
    createdBy: json["createdBy"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    imageCount: json["imageCount"],
    documentCount: json["documentCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "task_status": taskStatus,
    "assignedTo": assignedTo?.toJson(),
    "projectId": projectId,
    "dueDate": dueDate?.toIso8601String(),
    "title": title,
    "description": description,
    "createdBy": createdBy,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "imageCount": imageCount,
    "documentCount": documentCount,
  };
}

class AssignedTo {
  final Address? address;
  final String? fname;
  final String? lname;
  final String? userId;

  AssignedTo({
    this.address,
    this.fname,
    this.lname,
    this.userId,
  });

  factory AssignedTo.fromRawJson(String str) => AssignedTo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignedTo.fromJson(Map<String, dynamic> json) => AssignedTo(
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    fname: json["fname"],
    lname: json["lname"],
    userId: json["_userId"],
  );

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "fname": fname,
    "lname": lname,
    "_userId": userId,
  };
}

class Address {
  final String? streetAddress;

  Address({
    this.streetAddress,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    streetAddress: json["streetAddress"],
  );

  Map<String, dynamic> toJson() => {
    "streetAddress": streetAddress,
  };
}

class Attachment {
  final String? attachment;
  final String? attachmentType;
  final String? attachedToType;
  final String? projectId;
  final String? uploadedByUserId;
  final String? uploaderRole;
  final List<dynamic>? reactions;
  final String? attachedToId;
  final String? attachmentId;

  Attachment({
    this.attachment,
    this.attachmentType,
    this.attachedToType,
    this.projectId,
    this.uploadedByUserId,
    this.uploaderRole,
    this.reactions,
    this.attachedToId,
    this.attachmentId,
  });

  factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachment: json["attachment"],
    attachmentType: json["attachmentType"],
    attachedToType: json["attachedToType"],
    projectId: json["projectId"],
    uploadedByUserId: json["uploadedByUserId"],
    uploaderRole: json["uploaderRole"],
    reactions: json["reactions"] == null ? [] : List<dynamic>.from(json["reactions"]!.map((x) => x)),
    attachedToId: json["attachedToId"],
    attachmentId: json["_attachmentId"],
  );

  Map<String, dynamic> toJson() => {
    "attachment": attachment,
    "attachmentType": attachmentType,
    "attachedToType": attachedToType,
    "projectId": projectId,
    "uploadedByUserId": uploadedByUserId,
    "uploaderRole": uploaderRole,
    "reactions": reactions == null ? [] : List<dynamic>.from(reactions!.map((x) => x)),
    "attachedToId": attachedToId,
    "_attachmentId": attachmentId,
  };
}
