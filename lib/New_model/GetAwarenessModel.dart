// To parse this JSON data, do
//
//     final getAModel = getAModelFromJson(jsonString);

import 'dart:convert';

GetAModel getAModelFromJson(String str) => GetAModel.fromJson(json.decode(str));

String getAModelToJson(GetAModel data) => json.encode(data.toJson());

class GetAModel {
  GetAModel({
    this.error,
    this.message,
    required this.data,
  });

  bool? error;
  String? message;
  Data data;

  factory GetAModel.fromJson(Map<String, dynamic> json) => GetAModel(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.poster,
    this.leaflets,
    this.booklets,
    this.mPoster,
    this.video,
  });

  List<Booklet>? poster;
  List<Booklet>? leaflets;
  List<Booklet>? booklets;
  List<Booklet>? mPoster;
  List<Booklet>? video;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    poster: List<Booklet>.from(json["poster"].map((x) => Booklet.fromJson(x))),
    leaflets: List<Booklet>.from(json["leaflets"].map((x) => Booklet.fromJson(x))),
    booklets: List<Booklet>.from(json["booklets"].map((x) => Booklet.fromJson(x))),
    mPoster: List<Booklet>.from(json["m-poster"].map((x) => Booklet.fromJson(x))),
    video: List<Booklet>.from(json["video"].map((x) => Booklet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "poster": List<dynamic>.from(poster!.map((x) => x.toJson())),
    "leaflets": List<dynamic>.from(leaflets!.map((x) => x.toJson())),
    "booklets": List<dynamic>.from(booklets!.map((x) => x.toJson())),
    "m-poster": List<dynamic>.from(mPoster!.map((x) => x.toJson())),
    "video": List<dynamic>.from(video!.map((x) => x.toJson())),
  };
}

class Booklet {
  Booklet({
    this.userName,
    this.userImage,
    this.userAddress,
    this.userPhone,
    this.userDigree,
    this.id,
    this.title,
    this.awareInput,
    this.awareLanguage,
    this.date,
    this.image,
    this.status,
    this.pharmaId,
    this.type,
    this.isFav,
    this.isSelected
  });

  String? userName;
  String? userImage;
  String? userAddress;
  String? userPhone;
  String? userDigree;
  String? id;
  String? title;
  String? awareInput;
  String? awareLanguage;
  DateTime? date;
  String? image;
  String? status;
  String? pharmaId;
  String? type;
  bool? isFav;
  bool? isSelected;

  factory Booklet.fromJson(Map<String, dynamic> json) => Booklet(
    userName: json["user_name"],
    userImage: json["user_image"],
    userAddress: json["user_address"],
    userPhone: json["user_phone"],
    userDigree: json["user_digree"],
    id: json["id"],
    title: json["title"],
    awareInput: json["aware_input"],
    awareLanguage: json["aware_language"],
    date: DateTime.parse(json["date"]),
    image: json["image"],
    status: json["status"],
    pharmaId: json["pharma_id"],
    type: json["type"],
    isFav: json["is_fav"],
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_image": userImage,
    "user_address": userAddress,
    "user_phone": userPhone,
    "user_digree": userDigreeValues.reverse[userDigree],
    "id": id,
    "title": title,
    "aware_input": awareInput,
    "aware_language": awareLanguage,
    "date": date!.toIso8601String(),
    "image": image,
    "status": status,
    "pharma_id": pharmaId,
    "type": typeValues.reverse[type],
    "is_fav": isFav,
  };
}

enum Type { DOCTOR_AWARENESS, PHARMA_AWARENESS }

final typeValues = EnumValues({
  "doctor-awareness": Type.DOCTOR_AWARENESS,
  "pharma-awareness": Type.PHARMA_AWARENESS
});

enum UserDigree { UEYWYEY, B_PHARMA, DVGHDHR }

final userDigreeValues = EnumValues({
  "B- Pharma": UserDigree.B_PHARMA,
  "dvghdhr": UserDigree.DVGHDHR,
  "ueywyey": UserDigree.UEYWYEY
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
