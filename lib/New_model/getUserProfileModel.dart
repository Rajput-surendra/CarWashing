/// status : true
/// message : "User Profile"
/// data : [{"id":"5","username":"surendra","email":"surendra@gmail.com","mobile":"9632500741","otp":"8643","address":"Indore Madhya Pradesh","lat":"","lng":"","profile_pic":"https://alphawizzserver.com/car_wash/uploads/profile_pics/user.png"}]

class GetUserProfileModel {
  GetUserProfileModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetUserProfileModel.fromJson(dynamic json) {
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
GetUserProfileModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetUserProfileModel(  status: status ?? _status,
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
/// username : "surendra"
/// email : "surendra@gmail.com"
/// mobile : "9632500741"
/// otp : "8643"
/// address : "Indore Madhya Pradesh"
/// lat : ""
/// lng : ""
/// profile_pic : "https://alphawizzserver.com/car_wash/uploads/profile_pics/user.png"

class Data {
  Data({
      String? id, 
      String? username, 
      String? email, 
      String? mobile, 
      String? otp, 
      String? address, 
      String? lat, 
      String? lng, 
      String? profilePic,}){
    _id = id;
    _username = username;
    _email = email;
    _mobile = mobile;
    _otp = otp;
    _address = address;
    _lat = lat;
    _lng = lng;
    _profilePic = profilePic;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _otp = json['otp'];
    _address = json['address'];
    _lat = json['lat'];
    _lng = json['lng'];
    _profilePic = json['profile_pic'];
  }
  String? _id;
  String? _username;
  String? _email;
  String? _mobile;
  String? _otp;
  String? _address;
  String? _lat;
  String? _lng;
  String? _profilePic;
Data copyWith({  String? id,
  String? username,
  String? email,
  String? mobile,
  String? otp,
  String? address,
  String? lat,
  String? lng,
  String? profilePic,
}) => Data(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  otp: otp ?? _otp,
  address: address ?? _address,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  profilePic: profilePic ?? _profilePic,
);
  String? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get otp => _otp;
  String? get address => _address;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get profilePic => _profilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['otp'] = _otp;
    map['address'] = _address;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['profile_pic'] = _profilePic;
    return map;
  }

}