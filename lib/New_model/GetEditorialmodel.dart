// To parse this JSON data, do
//
//     final getEditorialmodel = getEditorialmodelFromJson(jsonString);

import 'dart:convert';

GetEditorialmodel getEditorialmodelFromJson(String str) => GetEditorialmodel.fromJson(json.decode(str));

String getEditorialmodelToJson(GetEditorialmodel data) => json.encode(data.toJson());

class GetEditorialmodel {
  GetEditorialmodel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<GetEdoDataList> data;

  factory GetEditorialmodel.fromJson(Map<String, dynamic> json) => GetEditorialmodel(
    error: json["error"],
    message: json["message"],
    data: List<GetEdoDataList>.from(json["data"].map((x) => GetEdoDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetEdoDataList {
  GetEdoDataList({
    required this.userName,
    required this.userImage,
    required this.userAddress,
    required this.userPhone,
    this.userDigree,
    required this.id,
    required this.title,
    this.awareInput,
    this.awareLanguage,
    required this.description,
    required this.date,
    required this.image,
    required this.status,
    required this.pharmaId,
    required this.type,
    required this.isFav,
    this.isSelected
  });
 bool? isSelected;
  String userName;
  String userImage;
  String userAddress;
  String userPhone;
  String? userDigree;
  String id;
  String title;
  String? awareInput;
  String? awareLanguage;
  String description;
  DateTime date;
  String image;
  String status;
  String pharmaId;
  String type;
  bool isFav;

  factory GetEdoDataList.fromJson(Map<String, dynamic> json) => GetEdoDataList(
    userName: json["user_name"],
    isSelected:false,
    userImage: json["user_image"],
    userAddress: json["user_address"]!,
    userPhone: json["user_phone"],
    userDigree: json["user_digree"],
    id: json["id"],
    title: json["title"],
    awareInput: json["aware_input"],
    awareLanguage: json["aware_language"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    image: json["image"],
    status: json["status"],
    pharmaId: json["pharma_id"],
    type: json["type"],
    isFav: json["is_fav"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userNameValues.reverse[userName],
    "user_image": userImage,
    "user_address": userAddressValues.reverse[userAddress],
    "user_phone": userPhone,
    "user_digree": userDigreeValues.reverse[userDigree],
    "id": id,
    "title": title,
    "aware_input": awareInput,
    "aware_language": awareLanguage,
    "description": description,
    "date": date.toIso8601String(),
    "image": image,
    "status": status,
    "pharma_id": pharmaId,
    "type": typeValues.reverse[type],
    "is_fav": isFav,
  };
}

enum Type { DOCTOR_EDITORIAL, PHARMA_EDITORIAL }

final typeValues = EnumValues({
  "doctor-editorial": Type.DOCTOR_EDITORIAL,
  "pharma-editorial": Type.PHARMA_EDITORIAL
});

enum UserAddress { THE_8989898989, YTUTUT }

final userAddressValues = EnumValues({
  "8989898989": UserAddress.THE_8989898989,
  "ytutut": UserAddress.YTUTUT
});

enum UserDigree { B_PHARMA }

final userDigreeValues = EnumValues({
  "B- Pharma": UserDigree.B_PHARMA
});

enum UserName { RGRR, GAUTAMATUL }

final userNameValues = EnumValues({
  "gautamatul": UserName.GAUTAMATUL,
  "rgrr": UserName.RGRR
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
