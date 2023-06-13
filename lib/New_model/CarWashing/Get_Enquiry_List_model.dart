/// status : true
/// message : "Enquiry lists"
/// data : [{"id":"12","user_id":"7","res_id":"1","name":"dggdhhr","mobile":"9787499494","message":"vzvdbdhdhdhfhd","created_at":"2023-06-13 09:34:17","update_at":"2023-06-13 09:34:17","logo":"https://alphawizzserver.com/car_wash/uploads/64871fa6c0fec.png","accessories_name":"Glass Cover","accessories_description":"Glass Cover\r\nGlass Cover\r\nGlass Cover"},{"id":"15","user_id":"7","res_id":"1","name":"gg","mobile":"2233556644","message":"fg","created_at":"2023-06-13 10:37:42","update_at":"2023-06-13 10:37:42","logo":"https://alphawizzserver.com/car_wash/uploads/64871fa6c0fec.png","accessories_name":"Glass Cover","accessories_description":"Glass Cover\r\nGlass Cover\r\nGlass Cover"}]

class GetEnquiryListModel {
  GetEnquiryListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetEnquiryListModel.fromJson(dynamic json) {
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
GetEnquiryListModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetEnquiryListModel(  status: status ?? _status,
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

/// id : "12"
/// user_id : "7"
/// res_id : "1"
/// name : "dggdhhr"
/// mobile : "9787499494"
/// message : "vzvdbdhdhdhfhd"
/// created_at : "2023-06-13 09:34:17"
/// update_at : "2023-06-13 09:34:17"
/// logo : "https://alphawizzserver.com/car_wash/uploads/64871fa6c0fec.png"
/// accessories_name : "Glass Cover"
/// accessories_description : "Glass Cover\r\nGlass Cover\r\nGlass Cover"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? resId, 
      String? name, 
      String? mobile, 
      String? message, 
      String? createdAt, 
      String? updateAt, 
      String? logo, 
      String? accessoriesName, 
      String? accessoriesDescription,}){
    _id = id;
    _userId = userId;
    _resId = resId;
    _name = name;
    _mobile = mobile;
    _message = message;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _logo = logo;
    _accessoriesName = accessoriesName;
    _accessoriesDescription = accessoriesDescription;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _resId = json['res_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _message = json['message'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    _logo = json['logo'];
    _accessoriesName = json['accessories_name'];
    _accessoriesDescription = json['accessories_description'];
  }
  String? _id;
  String? _userId;
  String? _resId;
  String? _name;
  String? _mobile;
  String? _message;
  String? _createdAt;
  String? _updateAt;
  String? _logo;
  String? _accessoriesName;
  String? _accessoriesDescription;
Data copyWith({  String? id,
  String? userId,
  String? resId,
  String? name,
  String? mobile,
  String? message,
  String? createdAt,
  String? updateAt,
  String? logo,
  String? accessoriesName,
  String? accessoriesDescription,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  resId: resId ?? _resId,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  message: message ?? _message,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
  logo: logo ?? _logo,
  accessoriesName: accessoriesName ?? _accessoriesName,
  accessoriesDescription: accessoriesDescription ?? _accessoriesDescription,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get resId => _resId;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  String? get logo => _logo;
  String? get accessoriesName => _accessoriesName;
  String? get accessoriesDescription => _accessoriesDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['res_id'] = _resId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['message'] = _message;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    map['logo'] = _logo;
    map['accessories_name'] = _accessoriesName;
    map['accessories_description'] = _accessoriesDescription;
    return map;
  }

}