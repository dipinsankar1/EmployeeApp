// To parse this JSON data, do
//
//     final checkinModel = checkinModelFromJson(jsonString);

import 'dart:convert';

List<CheckinModel> checkinModelFromJson(String str) => List<CheckinModel>.from(
    json.decode(str).map((x) => CheckinModel.fromJson(x)));

String checkinModelToJson(List<CheckinModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckinModel {
  CheckinModel({
    required this.checkin,
    required this.location,
    required this.purpose,
    required this.id,
    required this.employeeId,
  });

  DateTime checkin;
  String location;
  String purpose;
  String id;
  String employeeId;

  factory CheckinModel.fromJson(Map<String, dynamic> json) => CheckinModel(
        checkin: DateTime.parse(json["checkin"]),
        location: json["location"],
        purpose: json["purpose"],
        id: json["id"],
        employeeId: json["employeeId"],
      );

  Map<String, dynamic> toJson() => {
        "checkin": checkin.toIso8601String(),
        "location": location,
        "purpose": purpose,
        "id": id,
        "employeeId": employeeId,
      };
}
