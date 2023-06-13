/// error : false
/// message : "All Counter success"
/// data : [{"slug":"news","title":"News Update","image":"https://alphawizzserver.com/car_wash/uploads/img/news.png","counter":"2"},{"slug":"event","title":"Events & Webinars","image":"https://alphawizzserver.com/car_wash/uploads/img/event.png","counter":"0"},{"slug":"product","title":"Pharma Products","image":"https://alphawizzserver.com/car_wash/uploads/img/product.png","counter":"0"},{"slug":"editorial","title":"Editorial","image":"https://alphawizzserver.com/car_wash/uploads/img/editorial.png","counter":"0"},{"slug":"awareness","title":"Awareness Inputs","image":"https://alphawizzserver.com/car_wash/uploads/img/awareness.png","counter":"0"},{"slug":"advertisement","title":"Advertisement","image":"https://alphawizzserver.com/car_wash/uploads/img/advertisement.png","counter":"0"}]

class GetCountingModel {
  GetCountingModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetCountingModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetCountingModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetCountingModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// slug : "news"
/// title : "News Update"
/// image : "https://alphawizzserver.com/car_wash/uploads/img/news.png"
/// counter : "2"

class Data {
  Data({
      String? slug, 
      String? title, 
      String? image, 
      String? counter,}){
    _slug = slug;
    _title = title;
    _image = image;
    _counter = counter;
}

  Data.fromJson(dynamic json) {
    _slug = json['slug'];
    _title = json['title'];
    _image = json['image'];
    _counter = json['counter'];
  }
  String? _slug;
  String? _title;
  String? _image;
  String? _counter;
Data copyWith({  String? slug,
  String? title,
  String? image,
  String? counter,
}) => Data(  slug: slug ?? _slug,
  title: title ?? _title,
  image: image ?? _image,
  counter: counter ?? _counter,
);
  String? get slug => _slug;
  String? get title => _title;
  String? get image => _image;
  String? get counter => _counter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = _slug;
    map['title'] = _title;
    map['image'] = _image;
    map['counter'] = _counter;
    return map;
  }

}