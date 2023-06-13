/// status : true
/// message : "Accessories List"
/// data : [{"id":"1","name":"Glass Cover","description":"Glass Cover\r\nGlass Cover\r\nGlass Cover","logo":"https://alphawizzserver.com/car_wash/uploads/64871fa6c0fec.png","brand":"Ford Motor Company","model":"Sudan","is_favorite":false}]

class AccessoriesModel {
  AccessoriesModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AccessoriesModel.fromJson(dynamic json) {
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
AccessoriesModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => AccessoriesModel(  status: status ?? _status,
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

/// id : "1"
/// name : "Glass Cover"
/// description : "Glass Cover\r\nGlass Cover\r\nGlass Cover"
/// logo : "https://alphawizzserver.com/car_wash/uploads/64871fa6c0fec.png"
/// brand : "Ford Motor Company"
/// model : "Sudan"
/// is_favorite : false

class Data {
  Data({
      String? id, 
      String? name, 
      String? description, 
      String? logo, 
      String? brand, 
      String? model, 
      bool? isFavorite,}){
    _id = id;
    _name = name;
    _description = description;
    _logo = logo;
    _brand = brand;
    _model = model;
    _isFavorite = isFavorite;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _logo = json['logo'];
    _brand = json['brand'];
    _model = json['model'];
    _isFavorite = json['is_favorite'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _logo;
  String? _brand;
  String? _model;
  bool? _isFavorite;
Data copyWith({  String? id,
  String? name,
  String? description,
  String? logo,
  String? brand,
  String? model,
  bool? isFavorite,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  logo: logo ?? _logo,
  brand: brand ?? _brand,
  model: model ?? _model,
  isFavorite: isFavorite ?? _isFavorite,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get logo => _logo;
  String? get brand => _brand;
  String? get model => _model;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['logo'] = _logo;
    map['brand'] = _brand;
    map['model'] = _model;
    map['is_favorite'] = _isFavorite;
    return map;
  }

}