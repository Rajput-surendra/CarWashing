/// status : true
/// message : "Slider List"
/// data : [{"id":"5","banners_name":"Car Washing Banner","image":"https://alphawizzserver.com/car_wash/uploads/632d5736dc2b5.jpg"}]

class GetSliderModel {
  GetSliderModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetSliderModel.fromJson(dynamic json) {
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
GetSliderModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetSliderModel(  status: status ?? _status,
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

/// id : "5"
/// banners_name : "Car Washing Banner"
/// image : "https://alphawizzserver.com/car_wash/uploads/632d5736dc2b5.jpg"

class Data {
  Data({
      String? id, 
      String? bannersName, 
      String? image,}){
    _id = id;
    _bannersName = bannersName;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _bannersName = json['banners_name'];
    _image = json['image'];
  }
  String? _id;
  String? _bannersName;
  String? _image;
Data copyWith({  String? id,
  String? bannersName,
  String? image,
}) => Data(  id: id ?? _id,
  bannersName: bannersName ?? _bannersName,
  image: image ?? _image,
);
  String? get id => _id;
  String? get bannersName => _bannersName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['banners_name'] = _bannersName;
    map['image'] = _image;
    return map;
  }

}