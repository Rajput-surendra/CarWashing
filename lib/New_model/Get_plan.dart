/// status : true
/// message : "Plan lists"
/// data : [{"id":"1","name":"14 Days Subscription","description":"14 Days Subscription","amount":"1000.00","time":"14 days","type":"1","created_at":"2023-05-19 13:36:52","update_at":"2023-05-19 13:02:41","is_purchased":false},{"id":"2","name":"30 Days Plan","description":"30 Days Plan","amount":"2500.00","time":"30 days","type":"1","created_at":"2023-05-19 13:36:59","update_at":"2023-05-19 13:02:55","is_purchased":false},{"id":"3","name":"Gold Plan","description":"Gold Plan","amount":"5000.00","time":"3 Months","type":"2","created_at":"2023-05-19 13:36:59","update_at":"2023-05-19 13:03:09","is_purchased":false}]

class GetPlan {
  GetPlan({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetPlan.fromJson(dynamic json) {
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
GetPlan copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetPlan(  status: status ?? _status,
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
/// name : "14 Days Subscription"
/// description : "14 Days Subscription"
/// amount : "1000.00"
/// time : "14 days"
/// type : "1"
/// created_at : "2023-05-19 13:36:52"
/// update_at : "2023-05-19 13:02:41"
/// is_purchased : false

class Data {
  Data({
      String? id, 
      String? name, 
      String? description, 
      String? amount, 
      String? time, 
      String? type, 
      String? createdAt, 
      String? updateAt, 
      bool? isPurchased,}){
    _id = id;
    _name = name;
    _description = description;
    _amount = amount;
    _time = time;
    _type = type;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _isPurchased = isPurchased;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _amount = json['amount'];
    _time = json['time'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _amount;
  String? _time;
  String? _type;
  String? _createdAt;
  String? _updateAt;
  bool? _isPurchased;
Data copyWith({  String? id,
  String? name,
  String? description,
  String? amount,
  String? time,
  String? type,
  String? createdAt,
  String? updateAt,
  bool? isPurchased,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  amount: amount ?? _amount,
  time: time ?? _time,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get amount => _amount;
  String? get time => _time;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['amount'] = _amount;
    map['time'] = _time;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}