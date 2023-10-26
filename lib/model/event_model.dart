import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  List<String?> joinedUser;
  String? id;
  String eventName;
  String eventPic;
  String createdAt;
  String name;
  Timestamp fromTime;
  Timestamp toTime;
  String address;
  String location;
  int duration;
  String durationType;

  // DateTime dateTime;

  EventModel({
    required this.joinedUser,
    required this.id,
    required this.eventPic,
    required this.createdAt,
    required this.eventName,
    required this.name,
    required this.fromTime,
    required this.toTime,
    required this.address,
    required this.location,
    required this.duration,
    required this.durationType
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      joinedUser: List<String?>.from(map['joined_user'] ?? []),
      id: map['id'] ?? '',
      eventName: map['EventName'] ?? '',
      name: map['Name'] ?? '',
      fromTime: map['FromTime'] ?? '',
      toTime: map['ToTime'] ?? '',
      address: map['Address'] ?? '',
      location: map['Location'] ?? '',
      eventPic: map['EventPic'] ?? '',
      createdAt: map['CreatedAt'] ?? '',
      duration: map['duration'] ?? '',
      durationType: map['durationType'] ?? '',
    );
  }

  factory EventModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    return EventModel(
      joinedUser: List<String?>.from(data?['joined_user'] ?? []),
      id: data?['id'] ?? '',
      eventName: data?['EventName'] ?? '',
      name: data?['Name'] ?? '',
      fromTime: (data?['FromTime'] as Timestamp?) ??
          Timestamp.fromDate(DateTime(2023)),
      toTime:
      (data?['ToTime'] as Timestamp?) ?? Timestamp.fromDate(DateTime(2023)),
      address: data?['Address'] ?? '',
      location: data?['Location'] ?? '',
      eventPic: data?['EventPic'] ?? '',
      createdAt: data?['CreatedAt'] ?? '',
      duration: data?['duration'] ?? '',
      durationType: data?['durationType'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "CreatedAt": createdAt,
      "EventPic": eventPic,
      "EventName": eventName,
      "Name": name,
      "FromTime": fromTime,
      "ToTime": toTime,
      "joined_user": joinedUser,
      "Address": address,
      "Location": location,
      "duration": duration,
      "durationType": durationType,
    };
  }
}
