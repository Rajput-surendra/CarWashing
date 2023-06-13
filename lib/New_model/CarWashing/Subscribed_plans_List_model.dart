/// status : true
/// message : "Plan purchased successfully"
/// data : [{"id":"34","user_id":"7","plan_id":"1","transaction_id":"ugjyjjh","amount":"299.00","name":"gsgdgsh","mobile":"9859595995","address":" xbcxnfn xbxb","lat":null,"lng":null,"status":"0","time_slot":"11:30 PM  - 12:00 AM","end_date":"2023-07-09","created_at":"2023-06-13 13:38:33","time":"26","type":"1","time_text":""}]

class SubscribedPlansListModel {
  SubscribedPlansListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SubscribedPlansListModel.fromJson(dynamic json) {
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
SubscribedPlansListModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => SubscribedPlansListModel(  status: status ?? _status,
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

/// id : "34"
/// user_id : "7"
/// plan_id : "1"
/// transaction_id : "ugjyjjh"
/// amount : "299.00"
/// name : "gsgdgsh"
/// mobile : "9859595995"
/// address : " xbcxnfn xbxb"
/// lat : null
/// lng : null
/// status : "0"
/// time_slot : "11:30 PM  - 12:00 AM"
/// end_date : "2023-07-09"
/// created_at : "2023-06-13 13:38:33"
/// time : "26"
/// type : "1"
/// time_text : ""

class Data {
  Data({
      String? id, 
      String? userId, 
      String? planId, 
      String? transactionId, 
      String? amount, 
      String? name, 
      String? mobile, 
      String? address, 
      dynamic lat, 
      dynamic lng, 
      String? status, 
      String? timeSlot, 
      String? endDate, 
      String? createdAt, 
      String? time, 
      String? type, 
      String? timeText,}){
    _id = id;
    _userId = userId;
    _planId = planId;
    _transactionId = transactionId;
    _amount = amount;
    _name = name;
    _mobile = mobile;
    _address = address;
    _lat = lat;
    _lng = lng;
    _status = status;
    _timeSlot = timeSlot;
    _endDate = endDate;
    _createdAt = createdAt;
    _time = time;
    _type = type;
    _timeText = timeText;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _planId = json['plan_id'];
    _transactionId = json['transaction_id'];
    _amount = json['amount'];
    _name = json['name'];
    _mobile = json['mobile'];
    _address = json['address'];
    _lat = json['lat'];
    _lng = json['lng'];
    _status = json['status'];
    _timeSlot = json['time_slot'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _time = json['time'];
    _type = json['type'];
    _timeText = json['time_text'];
  }
  String? _id;
  String? _userId;
  String? _planId;
  String? _transactionId;
  String? _amount;
  String? _name;
  String? _mobile;
  String? _address;
  dynamic _lat;
  dynamic _lng;
  String? _status;
  String? _timeSlot;
  String? _endDate;
  String? _createdAt;
  String? _time;
  String? _type;
  String? _timeText;
Data copyWith({  String? id,
  String? userId,
  String? planId,
  String? transactionId,
  String? amount,
  String? name,
  String? mobile,
  String? address,
  dynamic lat,
  dynamic lng,
  String? status,
  String? timeSlot,
  String? endDate,
  String? createdAt,
  String? time,
  String? type,
  String? timeText,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  planId: planId ?? _planId,
  transactionId: transactionId ?? _transactionId,
  amount: amount ?? _amount,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  status: status ?? _status,
  timeSlot: timeSlot ?? _timeSlot,
  endDate: endDate ?? _endDate,
  createdAt: createdAt ?? _createdAt,
  time: time ?? _time,
  type: type ?? _type,
  timeText: timeText ?? _timeText,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get planId => _planId;
  String? get transactionId => _transactionId;
  String? get amount => _amount;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get address => _address;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  String? get status => _status;
  String? get timeSlot => _timeSlot;
  String? get endDate => _endDate;
  String? get createdAt => _createdAt;
  String? get time => _time;
  String? get type => _type;
  String? get timeText => _timeText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['plan_id'] = _planId;
    map['transaction_id'] = _transactionId;
    map['amount'] = _amount;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['status'] = _status;
    map['time_slot'] = _timeSlot;
    map['end_date'] = _endDate;
    map['created_at'] = _createdAt;
    map['time'] = _time;
    map['type'] = _type;
    map['time_text'] = _timeText;
    return map;
  }

}