/// error : false
/// message : "Doctor News Find Success!"
/// data : [{"id":"12","title":"new news","description":"this is discription","image":"uploads/media/2023/download_(28).jpg","doctor_id":"42","status":"1","date":"2023-03-24 10:51:42","end date":null,"time":null,"end time":null,"doc_name":"Shashank Saxena","doc_address":"MAHARAJA YESHWANT RAO HOSPITAL,INDORE ; Address, M.Y. Hospital, Indore","doc_degree":"M.B.B.S","profile_image":""},{"id":"13","title":"Test","description":"testq0","image":"uploads/media/2023/download_(28).jpg","doctor_id":"49","status":"1","date":"2023-03-24 10:51:47","end date":null,"time":null,"end time":null,"doc_name":"Shivansh Shukla","doc_address":"VIjay Nagar Indore","doc_degree":"B- Pharma","profile_image":"uploads/seller/download_(24).jpg"}]

class GetNewTypeModel {
  GetNewTypeModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetNewTypeModel.fromJson(dynamic json) {
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
GetNewTypeModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetNewTypeModel(  error: error ?? _error,
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

/// id : "12"
/// title : "new news"
/// description : "this is discription"
/// image : "uploads/media/2023/download_(28).jpg"
/// doctor_id : "42"
/// status : "1"
/// date : "2023-03-24 10:51:42"
/// end date : null
/// time : null
/// end time : null
/// doc_name : "Shashank Saxena"
/// doc_address : "MAHARAJA YESHWANT RAO HOSPITAL,INDORE ; Address, M.Y. Hospital, Indore"
/// doc_degree : "M.B.B.S"
/// profile_image : ""

class Data {
  Data({
      String? id,
      String? title, 
      String? description, 
      String? image, 
      String? doctorId, 
      String? status, 
      String? date, 
      dynamic enddate, 
      dynamic time, 
      dynamic endtime, 
      String? docName, 
      String? docAddress, 
      String? docDegree, 
      String? profileImage,}){
    _id = id;
    _title = title;
    _description = description;
    _image = image;
    _doctorId = doctorId;
    _status = status;
    _date = date;
    _enddate = enddate;
    _time = time;
    _endtime = endtime;
    _docName = docName;
    _docAddress = docAddress;
    _docDegree = docDegree;
    _profileImage = profileImage;
}

  Data.fromJson(dynamic json) {

    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _doctorId = json['doctor_id'];
    _status = json['status'];
    _date = json['date'];
    _enddate = json['end date'];
    _time = json['time'];
    _endtime = json['end time'];
    _docName = json['doc_name'];
    _docAddress = json['doc_address'];
    _docDegree = json['doc_degree'];
    _profileImage = json['profile_image'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _image;
  String? _doctorId;
  String? _status;
  String? _date;
  dynamic _enddate;
  dynamic _time;
  dynamic _endtime;
  String? _docName;
  String? _docAddress;
  String? _docDegree;
  String? _profileImage;
Data copyWith({  String? id,
  String? title,

  String? description,
  String? image,
  String? doctorId,
  String? status,
  String? date,
  dynamic enddate,
  dynamic time,
  dynamic endtime,
  String? docName,
  String? docAddress,
  String? docDegree,
  String? profileImage,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  image: image ?? _image,
  doctorId: doctorId ?? _doctorId,
  status: status ?? _status,
  date: date ?? _date,
  enddate: enddate ?? _enddate,
  time: time ?? _time,
  endtime: endtime ?? _endtime,
  docName: docName ?? _docName,
  docAddress: docAddress ?? _docAddress,
  docDegree: docDegree ?? _docDegree,
  profileImage: profileImage ?? _profileImage,
);
  String? get id => _id;
  bool? get isSelected => false;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  String? get doctorId => _doctorId;
  String? get status => _status;
  String? get date => _date;
  dynamic get enddate => _enddate;
  dynamic get time => _time;
  dynamic get endtime => _endtime;
  String? get docName => _docName;
  String? get docAddress => _docAddress;
  String? get docDegree => _docDegree;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['doctor_id'] = _doctorId;
    map['status'] = _status;
    map['date'] = _date;
    map['end date'] = _enddate;
    map['time'] = _time;
    map['end time'] = _endtime;
    map['doc_name'] = _docName;
    map['doc_address'] = _docAddress;
    map['doc_degree'] = _docDegree;
    map['profile_image'] = _profileImage;
    return map;
  }

}