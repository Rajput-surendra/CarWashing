// To parse this JSON data, do
//
//     final getWebinarModel = getWebinarModelFromJson(jsonString);

import 'dart:convert';

GetWebinarModel getWebinarModelFromJson(String str) => GetWebinarModel.fromJson(json.decode(str));

String getWebinarModelToJson(GetWebinarModel data) => json.encode(data.toJson());

class GetWebinarModel {
  GetWebinarModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<GetWebnDataList>? data;

  factory GetWebinarModel.fromJson(Map<String, dynamic> json) => GetWebinarModel(
    error: json["error"],
    message: json["message"],
    data: List<GetWebnDataList>.from(json["data"].map((x) => GetWebnDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetWebnDataList {
  GetWebnDataList({

    this.userName,
    this.userImage,
    this.userAddress,
    this.userPhone,
    this.userDigree,
    this.id,
    this.title,
    this.fromTime,
    this.toTime,
    this.startDate,
    this.endDate,
    this.description,
    this.link,
    this.image,
    this.topic,
    this.speaker,
    this.moderator,
    this.status,
    required this.date,
    this.pharmaId,
    this.type,
    this.isFav,
    this.isSelected
  });

  String? userName;
  bool? isSelected;
  String? userImage;
  String? userAddress;
  String? userPhone;
  UserDigree? userDigree;
  String? id;
  String? title;
  String? fromTime;
  String? toTime;
  String? startDate;
  String? endDate;
  String? description;
  String? link;
  String? image;
  String? topic;
  String? speaker;
  String? moderator;
  String? status;
  DateTime date;
  String? pharmaId;
  String? type;
  bool? isFav;

  factory GetWebnDataList.fromJson(Map<String, dynamic> json) => GetWebnDataList(
    userName: json["user_name"],
    isSelected: false,
    userImage: json["user_image"],
    userAddress: json["user_address"],
    userPhone: json["user_phone"],
    userDigree: userDigreeValues.map[json["user_digree"]],
    id: json["id"],
    title: json["title"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    description: json["description"],
    link: json["link"],
    image: json["image"],
    topic: json["topic"],
    speaker: json["speaker"],
    moderator: json["moderator"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    pharmaId: json["pharma_id"],
    type: json["type"],
    isFav: json["is_fav"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_image": userImage,
    "user_address": userAddress,
    "user_phone": userPhone,
    "user_digree": userDigreeValues.reverse[userDigree],
    "id": id,
    "title": title,
    "from_time": fromTime,
    "to_time": toTime,
    "start_date": startDate,
    "end_date": endDate,
    "description": description,
    "link": link,
    "image": image,
    "topic": topicValues.reverse[topic],
    "speaker": speakerValues.reverse[speaker],
    "moderator": moderatorValues.reverse[moderator],
    "status": status,
    "date": date.toIso8601String(),
    "pharma_id": pharmaId,
    "type": typeValues.reverse[type],
    "is_fav": isFav,
  };
}

enum Date { HG, EMPTY }

final dateValues = EnumValues({
  "": Date.EMPTY,
  "hg": Date.HG
});

enum Moderator { YTYU, FCFCVVBYBN, EMPTY, TRTR }

final moderatorValues = EnumValues({
  "": Moderator.EMPTY,
  "fcfcvvbybn": Moderator.FCFCVVBYBN,
  "trtr": Moderator.TRTR,
  "ytyu": Moderator.YTYU
});

enum Speaker { YU, TCRCVVVVB, EMPTY, TRTR }

final speakerValues = EnumValues({
  "": Speaker.EMPTY,
  "tcrcvvvvb": Speaker.TCRCVVVVB,
  "trtr": Speaker.TRTR,
  "yu": Speaker.YU
});

enum Topic { YTYTU, TCTCVTGGTG, EMPTY, RTTRT }

final topicValues = EnumValues({
  "": Topic.EMPTY,
  "rttrt": Topic.RTTRT,
  "tctcvtggtg": Topic.TCTCVTGGTG,
  "ytytu": Topic.YTYTU
});

enum Type { DOCTOR_WEBINAR, PHARMA_WEBINAR }

final typeValues = EnumValues({
  "doctor-webinar": Type.DOCTOR_WEBINAR,
  "pharma-webinar": Type.PHARMA_WEBINAR
});

enum UserDigree { JHGDFJHG, B_PHARMA, M_B_B_S }

final userDigreeValues = EnumValues({
  "B- Pharma": UserDigree.B_PHARMA,
  "jhgdfjhg": UserDigree.JHGDFJHG,
  "M.B.B.S": UserDigree.M_B_B_S
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
