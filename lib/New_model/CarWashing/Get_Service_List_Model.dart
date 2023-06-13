/// status : true
/// message : "Brands List"
/// data : [{"id":"90","c_name":"Sudan","c_name_a":"","icon":"","sub_title":"","description":"Sudan","img":"648709260f4e7.png","type":"vip","p_id":"8","addons":"","lists":null,"image":"https://alphawizzserver.com/car_wash/uploads/648709260f4e7.png"},{"id":"91","c_name":"Mercedes","c_name_a":"","icon":"","sub_title":"","description":"Mercedes","img":"6487090cafd6c.jpg","type":"vip","p_id":"8","addons":"","lists":null,"image":"https://alphawizzserver.com/car_wash/uploads/6487090cafd6c.jpg"},{"id":"92","c_name":"Chevrolet","c_name_a":"","icon":"","sub_title":"","description":"Chevrolet","img":"648709050c2db.png","type":"vip","p_id":"7","addons":"","lists":null,"image":"https://alphawizzserver.com/car_wash/uploads/648709050c2db.png"},{"id":"94","c_name":"BMW iX","c_name_a":"","icon":"","sub_title":"","description":"BMW iX","img":"64870e1529db6.png","type":"vip","p_id":"8","addons":"","lists":null,"image":"https://alphawizzserver.com/car_wash/uploads/64870e1529db6.png"}]

class GetServiceListModel {
  GetServiceListModel({
      bool? status, 
      String? message, 
      List<ServiceListData>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetServiceListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceListData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ServiceListData>? _data;
GetServiceListModel copyWith({  bool? status,
  String? message,
  List<ServiceListData>? data,
}) => GetServiceListModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<ServiceListData>? get data => _data;

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

/// id : "90"
/// c_name : "Sudan"
/// c_name_a : ""
/// icon : ""
/// sub_title : ""
/// description : "Sudan"
/// img : "648709260f4e7.png"
/// type : "vip"
/// p_id : "8"
/// addons : ""
/// lists : null
/// image : "https://alphawizzserver.com/car_wash/uploads/648709260f4e7.png"

class ServiceListData {
  ServiceListData({
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

  ServiceListData.fromJson(dynamic json) {
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
ServiceListData copyWith({  String? id,
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
}) => ServiceListData(  id: id ?? _id,
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