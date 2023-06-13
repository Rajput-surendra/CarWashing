// To parse this JSON data, do
//
//     final addAwarenessMultiDataTypeResponse = addAwarenessMultiDataTypeResponseFromJson(jsonString);

import 'dart:convert';

AddAwarenessMultiDataTypeResponse addAwarenessMultiDataTypeResponseFromJson(String str) => AddAwarenessMultiDataTypeResponse.fromJson(json.decode(str));

String addAwarenessMultiDataTypeResponseToJson(AddAwarenessMultiDataTypeResponse data) => json.encode(data.toJson());

class AddAwarenessMultiDataTypeResponse {
  AddAwarenessMultiDataTypeResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<AddAwarenessDataList>? data;

  factory AddAwarenessMultiDataTypeResponse.fromJson(Map<String, dynamic> json) => AddAwarenessMultiDataTypeResponse(
    error: json["error"],
    message: json["message"],
    data: List<AddAwarenessDataList>.from(json["data"].map((x) => AddAwarenessDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddAwarenessDataList {
  AddAwarenessDataList({
    this.image,
    this.language,
    this.title,
    this.status,
    this.awareInput,
    this.doctorId,
  });

  String? image;
  String? language;
  String? title;
  int? status;
  String? awareInput;
  String? doctorId;

  factory AddAwarenessDataList.fromJson(Map<String, dynamic> json) => AddAwarenessDataList(
    image: json["image"],
    language: json["language"],
    title: json["title"],
    status: json["status"],
    awareInput: json["aware_input"],
    doctorId: json["doctor_id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "language": language,
    "title": title,
    "status": status,
    "aware_input": awareInput,
    "doctor_id": doctorId,
  };
}
