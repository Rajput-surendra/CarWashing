/// status : true
/// message : "Subscription List"
/// data : [{"id":"1","title":"Platinum","description":"Platinum","price":"0.00","model_type":"90","vehicle_type":"2","image":"https://alphawizzserver.com/car_wash/uploads/64830e2f6aa0b.png","json":"[]","created_at":"2022-09-28 08:15:01","updated_at":"2023-06-13 09:56:40","plans":[{"id":"1","type":"1","time":"26","amount":"299.00","vehicle_type":"0","created_at":"2023-06-09 11:34:07","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"First","time_text":"26 Days","is_purchased":false},{"id":"2","type":"2","time":"3","amount":"999.00","vehicle_type":"0","created_at":"2023-06-09 11:26:48","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"Second","time_text":"3 Months","is_purchased":false},{"id":"3","type":"3","time":"1","amount":"1999.00","vehicle_type":"0","created_at":"2023-06-09 11:26:48","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"Third","time_text":"1 Year","is_purchased":false},{"id":"4","type":"2","time":"6","amount":"1599.00","vehicle_type":"0","created_at":"2023-06-09 12:12:37","updated_at":"2023-06-09 12:12:37","plan_id":"1","title":"Fourth","time_text":"6 Months","is_purchased":false}]}]

class GetSubscriptionPlansModel {
  GetSubscriptionPlansModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetSubscriptionPlansModel.fromJson(dynamic json) {
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
GetSubscriptionPlansModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetSubscriptionPlansModel(  status: status ?? _status,
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
/// title : "Platinum"
/// description : "Platinum"
/// price : "0.00"
/// model_type : "90"
/// vehicle_type : "2"
/// image : "https://alphawizzserver.com/car_wash/uploads/64830e2f6aa0b.png"
/// json : "[]"
/// created_at : "2022-09-28 08:15:01"
/// updated_at : "2023-06-13 09:56:40"
/// plans : [{"id":"1","type":"1","time":"26","amount":"299.00","vehicle_type":"0","created_at":"2023-06-09 11:34:07","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"First","time_text":"26 Days","is_purchased":false},{"id":"2","type":"2","time":"3","amount":"999.00","vehicle_type":"0","created_at":"2023-06-09 11:26:48","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"Second","time_text":"3 Months","is_purchased":false},{"id":"3","type":"3","time":"1","amount":"1999.00","vehicle_type":"0","created_at":"2023-06-09 11:26:48","updated_at":"2023-06-09 11:26:48","plan_id":"1","title":"Third","time_text":"1 Year","is_purchased":false},{"id":"4","type":"2","time":"6","amount":"1599.00","vehicle_type":"0","created_at":"2023-06-09 12:12:37","updated_at":"2023-06-09 12:12:37","plan_id":"1","title":"Fourth","time_text":"6 Months","is_purchased":false}]

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? price, 
      String? modelType, 
      String? vehicleType, 
      String? image, 
      String? json, 
      String? createdAt, 
      String? updatedAt, 
      List<Plans>? plans,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _modelType = modelType;
    _vehicleType = vehicleType;
    _image = image;
    _json = json;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _plans = plans;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _modelType = json['model_type'];
    _vehicleType = json['vehicle_type'];
    _image = json['image'];
    _json = json['json'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['plans'] != null) {
      _plans = [];
      json['plans'].forEach((v) {
        _plans?.add(Plans.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _description;
  String? _price;
  String? _modelType;
  String? _vehicleType;
  String? _image;
  String? _json;
  String? _createdAt;
  String? _updatedAt;
  List<Plans>? _plans;
Data copyWith({  String? id,
  String? title,
  String? description,
  String? price,
  String? modelType,
  String? vehicleType,
  String? image,
  String? json,
  String? createdAt,
  String? updatedAt,
  List<Plans>? plans,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  modelType: modelType ?? _modelType,
  vehicleType: vehicleType ?? _vehicleType,
  image: image ?? _image,
  json: json ?? _json,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  plans: plans ?? _plans,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get price => _price;
  String? get modelType => _modelType;
  String? get vehicleType => _vehicleType;
  String? get image => _image;
  String? get json => _json;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Plans>? get plans => _plans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['model_type'] = _modelType;
    map['vehicle_type'] = _vehicleType;
    map['image'] = _image;
    map['json'] = _json;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_plans != null) {
      map['plans'] = _plans?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// type : "1"
/// time : "26"
/// amount : "299.00"
/// vehicle_type : "0"
/// created_at : "2023-06-09 11:34:07"
/// updated_at : "2023-06-09 11:26:48"
/// plan_id : "1"
/// title : "First"
/// time_text : "26 Days"
/// is_purchased : false

class Plans {
  Plans({
      String? id, 
      String? type, 
      String? time, 
      String? amount, 
      String? vehicleType, 
      String? createdAt, 
      String? updatedAt, 
      String? planId, 
      String? title, 
      String? timeText, 
      bool? isPurchased,}){
    _id = id;
    _type = type;
    _time = time;
    _amount = amount;
    _vehicleType = vehicleType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _planId = planId;
    _title = title;
    _timeText = timeText;
    _isPurchased = isPurchased;
}

  Plans.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _time = json['time'];
    _amount = json['amount'];
    _vehicleType = json['vehicle_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _planId = json['plan_id'];
    _title = json['title'];
    _timeText = json['time_text'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _type;
  String? _time;
  String? _amount;
  String? _vehicleType;
  String? _createdAt;
  String? _updatedAt;
  String? _planId;
  String? _title;
  String? _timeText;
  bool? _isPurchased;
Plans copyWith({  String? id,
  String? type,
  String? time,
  String? amount,
  String? vehicleType,
  String? createdAt,
  String? updatedAt,
  String? planId,
  String? title,
  String? timeText,
  bool? isPurchased,
}) => Plans(  id: id ?? _id,
  type: type ?? _type,
  time: time ?? _time,
  amount: amount ?? _amount,
  vehicleType: vehicleType ?? _vehicleType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  planId: planId ?? _planId,
  title: title ?? _title,
  timeText: timeText ?? _timeText,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get type => _type;
  String? get time => _time;
  String? get amount => _amount;
  String? get vehicleType => _vehicleType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get planId => _planId;
  String? get title => _title;
  String? get timeText => _timeText;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['time'] = _time;
    map['amount'] = _amount;
    map['vehicle_type'] = _vehicleType;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['plan_id'] = _planId;
    map['title'] = _title;
    map['time_text'] = _timeText;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}