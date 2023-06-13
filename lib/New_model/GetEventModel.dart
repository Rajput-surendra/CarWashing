// To parse this JSON data, do
//
//     final getEventModel = getEventModelFromJson(jsonString);

import 'dart:convert';

GetEventModel getEventModelFromJson(String str) => GetEventModel.fromJson(json.decode(str));

String getEventModelToJson(GetEventModel data) => json.encode(data.toJson());

class GetEventModel {
  GetEventModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<EventDataList> data;

  factory GetEventModel.fromJson(Map<String, dynamic> json) => GetEventModel(
    error: json["error"],
    message: json["message"],
    data: List<EventDataList>.from(json["data"].map((x) => EventDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EventDataList {
  EventDataList({
    required this.userName,
    required this.userImage,
    required this.userAddress,
    required this.userPhone,
    this.userDigree,
    required this.id,
    required this.title,
    required this.name,
    required this.mobile,
    required this.startDate,
    required this.endDate,
    required this.designation,
    required this.status,
    required this.description,
    required this.link,
    required this.address,
    required this.date,
    required this.image,
    required this.pharmaId,
    required this.type,
    this.isSelected,
    required this.isFav,
  });

  String userName;
  bool? isSelected;
  String userImage;
  String userAddress;
  String userPhone;
  String? userDigree;
  String id;
  String title;
  String name;
  String mobile;
  String startDate;
  String endDate;
  String designation;
  String status;
  String description;
  String link;
  String address;
  DateTime date;
  String image;
  String pharmaId;
  String type;
  bool isFav;

  factory EventDataList.fromJson(Map<String, dynamic> json) => EventDataList(
    userName: json["user_name"],
    isSelected: false,
    userImage: json["user_image"],
    userAddress: json["user_address"],
    userPhone: json["user_phone"],
    userDigree: json["user_digree"],
    id: json["id"],
    title: json["title"],
    name: json["name"],
    mobile: json["mobile"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    designation: json["designation"],
    status: json["status"],
    description: json["description"],
    link: json["link"],
    address: json["address"],
    date: DateTime.parse(json["date"]),
    image: json["image"],
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
    "name": name,
    "mobile": mobile,
    "start_date": startDate,
    "end_date": endDate,
    "designation": designation,
    "status": status,
    "description": description,
    "link": link,
    "address": address,
    "date": date.toIso8601String(),
    "image": image,
    "pharma_id": pharmaId,
    "type": type,
    "is_fav": isFav,
  };
}

// enum Type { DOCTOR_EVENT, PHARMA_EVENT }
//
// final typeValues = EnumValues({
//   "doctor-event": Type.DOCTOR_EVENT,
//   "pharma-event": Type.PHARMA_EVENT
// });

enum UserAddress { THE_8989898989, FJGHJ, INDIA, YTUTUT }

final userAddressValues = EnumValues({
  "fjghj": UserAddress.FJGHJ,
  "india": UserAddress.INDIA,
  "8989898989": UserAddress.THE_8989898989,
  "ytutut": UserAddress.YTUTUT
});

enum UserDigree { B_PHARMA, JHGDFJHG }

final userDigreeValues = EnumValues({
  "B- Pharma": UserDigree.B_PHARMA,
  "jhgdfjhg": UserDigree.JHGDFJHG
});

enum UserName { RGRR, ATUL, TTTTT, GAUTAMATUL }

final userNameValues = EnumValues({
  "Atul": UserName.ATUL,
  "gautamatul": UserName.GAUTAMATUL,
  "rgrr": UserName.RGRR,
  "ttttt": UserName.TTTTT
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
