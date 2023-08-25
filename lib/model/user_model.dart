import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String profileImage;
  String createdAt;
  String phone;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.createdAt,
    required this.phone,
    required this.uid,
  });

//from map ...fetching data from server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'] ?? '',
      createdAt: map['createdAt'] ?? '',
      phone: map['phone'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  //to map sending data to server
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "profileImage": profileImage,
      "createdAt": createdAt,
      "phone": phone,
      "uid": uid,
    };
  }

  static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> e) {}
}
