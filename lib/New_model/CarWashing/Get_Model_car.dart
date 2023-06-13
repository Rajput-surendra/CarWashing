/// status : true
/// message : "Brands List"
/// data : [{"id":"92","c_name":"Chevrolet","c_name_a":"","icon":"","sub_title":"","description":"Chevrolet","img":"648709050c2db.png","type":"vip","p_id":"7","addons":"","lists":null,"image":"https://alphawizzserver.com/car_wash/uploads/648709050c2db.png"}]

class GetModelCar {
  GetModelCar({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetModelCar.fromJson(dynamic json) {
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
GetModelCar copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetModelCar(  status: status ?? _status,
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

/// id : "92"
/// c_name : "Chevrolet"
/// c_name_a : ""
/// icon : ""
/// sub_title : ""
/// description : "Chevrolet"
/// img : "648709050c2db.png"
/// type : "vip"
/// p_id : "7"
/// addons : ""
/// lists : null
/// image : "https://alphawizzserver.com/car_wash/uploads/648709050c2db.png"

class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      String? pId, 
      String? addons, 
      dynamic lists, 
      String? image,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
    _addons = addons;
    _lists = lists;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _addons = json['addons'];
    _lists = json['lists'];
    _image = json['image'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  String? _pId;
  String? _addons;
  dynamic _lists;
  String? _image;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
  String? addons,
  dynamic lists,
  String? image,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  addons: addons ?? _addons,
  lists: lists ?? _lists,
  image: image ?? _image,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;
  String? get addons => _addons;
  dynamic get lists => _lists;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['addons'] = _addons;
    map['lists'] = _lists;
    map['image'] = _image;
    return map;
  }

}