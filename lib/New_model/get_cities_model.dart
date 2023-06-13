// To parse this JSON data, do
//
//     final getCitiesResponseModel = getCitiesResponseModelFromJson(jsonString);

import 'dart:convert';

GetCitiesResponseModel getCitiesResponseModelFromJson(String str) => GetCitiesResponseModel.fromJson(json.decode(str));

String getCitiesResponseModelToJson(GetCitiesResponseModel data) => json.encode(data.toJson());

class GetCitiesResponseModel {
  bool? status;
  String? message;
  List<GetCitiesDataNew>? data;

  GetCitiesResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetCitiesResponseModel.fromJson(Map<String, dynamic> json) => GetCitiesResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<GetCitiesDataNew>.from(json["data"].map((x) => GetCitiesDataNew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetCitiesDataNew {
  String? id;
  String? name;
  String? stateId;
  DateTime? createdAt;

  GetCitiesDataNew({
    this.id,
    this.name,
    this.stateId,
    this.createdAt,
  });

  factory GetCitiesDataNew.fromJson(Map<String, dynamic> json) => GetCitiesDataNew(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "created_at": createdAt!.toIso8601String(),
  };
}
