import 'dart:convert';

class UserProfileDetailsModel {
  final String? fname;
  final String? lname;
  final String? email;
  final ProfileImage? profileImage;
  final String? fcmToken;
  final String? role;
  final String? superVisorsManagerId;
  final bool? isEmailVerified;
  final bool? isDeleted;
  final bool? isResetPassword;
  final int? failedLoginAttempts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? address;
  final String? phoneNumber;
  final String? userId;

  UserProfileDetailsModel({
    this.fname,
    this.lname,
    this.email,
    this.profileImage,
    this.fcmToken,
    this.role,
    this.superVisorsManagerId,
    this.isEmailVerified,
    this.isDeleted,
    this.isResetPassword,
    this.failedLoginAttempts,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.address,
    this.phoneNumber,
    this.userId,
  });

  factory UserProfileDetailsModel.fromRawJson(String str) => UserProfileDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileDetailsModel.fromJson(Map<String, dynamic> json) => UserProfileDetailsModel(
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    profileImage: json["profileImage"] == null ? null : ProfileImage.fromJson(json["profileImage"]),
    fcmToken: json["fcmToken"],
    role: json["role"],
    superVisorsManagerId: json["superVisorsManagerId"],
    isEmailVerified: json["isEmailVerified"],
    isDeleted: json["isDeleted"],
    isResetPassword: json["isResetPassword"],
    failedLoginAttempts: json["failedLoginAttempts"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    userId: json["_userId"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "email": email,
    "profileImage": profileImage?.toJson(),
    "fcmToken": fcmToken,
    "role": role,
    "superVisorsManagerId": superVisorsManagerId,
    "isEmailVerified": isEmailVerified,
    "isDeleted": isDeleted,
    "isResetPassword": isResetPassword,
    "failedLoginAttempts": failedLoginAttempts,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "address": address,
    "phoneNumber": phoneNumber,
    "_userId": userId,
  };
}

class ProfileImage {
  final String? imageUrl;
  final String? id;

  ProfileImage({
    this.imageUrl,
    this.id,
  });

  factory ProfileImage.fromRawJson(String str) => ProfileImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    imageUrl: json["imageUrl"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "_id": id,
  };
}
