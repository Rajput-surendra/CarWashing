// To parse this JSON data, do
//
//     final newModel = newModelFromJson(jsonString);

import 'dart:convert';

NewModel newModelFromJson(String str) => NewModel.fromJson(json.decode(str));

String newModelToJson(NewModel data) => json.encode(data.toJson());

class NewModel {
  NewModel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<DoctorNewsData> data;

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
    error: json["error"],
    message: json["message"],
    data: List<DoctorNewsData>.from(json["data"].map((x) => DoctorNewsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DoctorNewsData {
  DoctorNewsData({
     this.id,
     this.title,
     this.description,
     this.image,
     this.doctorId,
     this.status,
     this.date,
     this.docName,
     this.docAddress,
     this.docDegree,
     this.profileImage,
     this.isSelected,
  });

  String? id;
  bool? isSelected;
  String? title;
  String? description;
  String? image;
  String? doctorId;
  String? status;
  DateTime? date;
  String? docName;
  String? docAddress;
  String? docDegree;
  String? profileImage;

  factory DoctorNewsData.fromJson(Map<String, dynamic> json) => DoctorNewsData(
    id: json["id"],
    isSelected: false,
    title: json["title"],
    description: json["description"],
    image: json["image"],
    doctorId: json["doctor_id"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    docName: json["doc_name"],
    docAddress:json["doc_address"],
    docDegree: json["doc_degree"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "doctor_id": doctorId,
    "status": status,
    "date": date!.toIso8601String(),
    "doc_name": docNameValues.reverse[docName],
    "doc_address": docAddressValues.reverse[docAddress],
    "doc_degree": docDegreeValues.reverse[docDegree],
    "profile_image": profileImageValues.reverse[profileImage],
  };
}

enum DocAddress { FJGHJ, THE_8989898989 }

final docAddressValues = EnumValues({
  "fjghj": DocAddress.FJGHJ,
  "8989898989": DocAddress.THE_8989898989
});

enum DocDegree { JHGDFJHG, B_PHARMA }

final docDegreeValues = EnumValues({
  "B- Pharma": DocDegree.B_PHARMA,
  "jhgdfjhg": DocDegree.JHGDFJHG
});

enum DocName { ATUL, RGRR }

final docNameValues = EnumValues({
  "Atul": DocName.ATUL,
  "rgrr": DocName.RGRR
});

enum ProfileImage { UPLOADS_SELLER_PHARMACUITCAL_COMPANY_PROFILE_JPG, UPLOADS_SELLER_SCREENSHOT_20221221121938_PNG }

final profileImageValues = EnumValues({
  "uploads/seller/pharmacuitcal-company-profile.jpg": ProfileImage.UPLOADS_SELLER_PHARMACUITCAL_COMPANY_PROFILE_JPG,
  "uploads/seller/Screenshot_20221221_121938.png": ProfileImage.UPLOADS_SELLER_SCREENSHOT_20221221121938_PNG
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
