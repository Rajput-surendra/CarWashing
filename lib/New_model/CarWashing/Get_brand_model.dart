/// status : true
/// message : "Brands List"
/// data : [{"id":"7","title":"Ford Motor Company","description":"Ford Motor Company","image":"https://alphawizzserver.com/car_wash/uploads/64870aeb8623c.png","created_at":"2023-06-12 12:09:57","updated_at":"2023-06-12 12:09:15"},{"id":"8","title":"BMW Group","description":"BMW Group","image":"https://alphawizzserver.com/car_wash/uploads/64870aff2778f.jpg","created_at":"2023-06-12 12:10:11","updated_at":"2023-06-12 12:09:35"}]

class GetBrandModel {
  GetBrandModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetBrandModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetBrandModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetBrandModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "7"
/// title : "Ford Motor Company"
/// description : "Ford Motor Company"
/// image : "https://alphawizzserver.com/car_wash/uploads/64870aeb8623c.png"
/// created_at : "2023-06-12 12:09:57"
/// updated_at : "2023-06-12 12:09:15"

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? title,
  String? description,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}