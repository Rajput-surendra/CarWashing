/// status : true
/// message : "My purchased plan"
/// data : [{"expiry_date":"2023-06-02","purchase_date":"2023-05-19 18:13:58","id":"1","name":"14 Days Subscription","description":"14 Days Subscription","amount":"1000.00","time":"14","type":"1","created_at":"2023-05-19 13:36:52","update_at":"2023-05-19 13:02:41"}]

class CheckPlanModel {
  CheckPlanModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CheckPlanModel.fromJson(dynamic json) {
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
CheckPlanModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => CheckPlanModel(  status: status ?? _status,
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

/// expiry_date : "2023-06-02"
/// purchase_date : "2023-05-19 18:13:58"
/// id : "1"
/// name : "14 Days Subscription"
/// description : "14 Days Subscription"
/// amount : "1000.00"
/// time : "14"
/// type : "1"
/// created_at : "2023-05-19 13:36:52"
/// update_at : "2023-05-19 13:02:41"

class Data {
  Data({
      String? expiryDate, 
      String? purchaseDate, 
      String? id, 
      String? name, 
      String? description, 
      String? amount, 
      String? time, 
      String? type, 
      String? createdAt, 
      String? updateAt,}){
    _expiryDate = expiryDate;
    _purchaseDate = purchaseDate;
    _id = id;
    _name = name;
    _description = description;
    _amount = amount;
    _time = time;
    _type = type;
    _createdAt = createdAt;
    _updateAt = updateAt;
}

  Data.fromJson(dynamic json) {
    _expiryDate = json['expiry_date'];
    _purchaseDate = json['purchase_date'];
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _amount = json['amount'];
    _time = json['time'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
  }
  String? _expiryDate;
  String? _purchaseDate;
  String? _id;
  String? _name;
  String? _description;
  String? _amount;
  String? _time;
  String? _type;
  String? _createdAt;
  String? _updateAt;
Data copyWith({  String? expiryDate,
  String? purchaseDate,
  String? id,
  String? name,
  String? description,
  String? amount,
  String? time,
  String? type,
  String? createdAt,
  String? updateAt,
}) => Data(  expiryDate: expiryDate ?? _expiryDate,
  purchaseDate: purchaseDate ?? _purchaseDate,
  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  amount: amount ?? _amount,
  time: time ?? _time,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
);
  String? get expiryDate => _expiryDate;
  String? get purchaseDate => _purchaseDate;
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get amount => _amount;
  String? get time => _time;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expiry_date'] = _expiryDate;
    map['purchase_date'] = _purchaseDate;
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['amount'] = _amount;
    map['time'] = _time;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    return map;
  }

}