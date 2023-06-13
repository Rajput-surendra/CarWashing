/// error : false
/// message : "Doctor Event Find Success!"
/// data : [{"id":"19","title":"fhdhdhff","name":"","mobile":"","start_date":"2023-03-29","end_date":"2023-03-30","designation":"","status":"1","description":"","link":"vhfhfjfjf","address":"","date":"2023-03-29 13:20:02","image":"uploads/media/2023/6423ed3717871.jpg","doctor_id":"49","doc_name":"Devesh","doc_address":"VIjay Nagar Indore","doc_degree":"B- Pharma","profile_image":"istockphoto-1095468748-612x6123.jpg"}]

class GetEventListDeteilsModel {
  GetEventListDeteilsModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetEventListDeteilsModel.fromJson(dynamic json) {
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
GetEventListDeteilsModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetEventListDeteilsModel(  error: error ?? _error,
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

/// id : "19"
/// title : "fhdhdhff"
/// name : ""
/// mobile : ""
/// start_date : "2023-03-29"
/// end_date : "2023-03-30"
/// designation : ""
/// status : "1"
/// description : ""
/// link : "vhfhfjfjf"
/// address : ""
/// date : "2023-03-29 13:20:02"
/// image : "uploads/media/2023/6423ed3717871.jpg"
/// doctor_id : "49"
/// doc_name : "Devesh"
/// doc_address : "VIjay Nagar Indore"
/// doc_degree : "B- Pharma"
/// profile_image : "istockphoto-1095468748-612x6123.jpg"

class Data {
  Data({
      String? id, 
      String? title, 
      String? name, 
      String? mobile, 
      String? startDate, 
      String? endDate, 
      String? designation, 
      String? status, 
      String? description, 
      String? link, 
      String? address, 
      String? date, 
      String? image, 
      String? doctorId, 
      String? docName, 
      String? docAddress, 
      String? docDegree, 
      String? profileImage,}){
    _id = id;
    _title = title;
    _name = name;
    _mobile = mobile;
    _startDate = startDate;
    _endDate = endDate;
    _designation = designation;
    _status = status;
    _description = description;
    _link = link;
    _address = address;
    _date = date;
    _image = image;
    _doctorId = doctorId;
    _docName = docName;
    _docAddress = docAddress;
    _docDegree = docDegree;
    _profileImage = profileImage;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _name = json['name'];
    _mobile = json['mobile'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _designation = json['designation'];
    _status = json['status'];
    _description = json['description'];
    _link = json['link'];
    _address = json['address'];
    _date = json['date'];
    _image = json['image'];
    _doctorId = json['doctor_id'];
    _docName = json['doc_name'];
    _docAddress = json['doc_address'];
    _docDegree = json['doc_degree'];
    _profileImage = json['profile_image'];
  }
  String? _id;
  String? _title;
  String? _name;
  String? _mobile;
  String? _startDate;
  String? _endDate;
  String? _designation;
  String? _status;
  String? _description;
  String? _link;
  String? _address;
  String? _date;
  String? _image;
  String? _doctorId;
  String? _docName;
  String? _docAddress;
  String? _docDegree;
  String? _profileImage;
Data copyWith({  String? id,
  String? title,
  String? name,
  String? mobile,
  String? startDate,
  String? endDate,
  String? designation,
  String? status,
  String? description,
  String? link,
  String? address,
  String? date,
  String? image,
  String? doctorId,
  String? docName,
  String? docAddress,
  String? docDegree,
  String? profileImage,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  designation: designation ?? _designation,
  status: status ?? _status,
  description: description ?? _description,
  link: link ?? _link,
  address: address ?? _address,
  date: date ?? _date,
  image: image ?? _image,
  doctorId: doctorId ?? _doctorId,
  docName: docName ?? _docName,
  docAddress: docAddress ?? _docAddress,
  docDegree: docDegree ?? _docDegree,
  profileImage: profileImage ?? _profileImage,
);
  String? get id => _id;
  String? get title => _title;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get designation => _designation;
  String? get status => _status;
  String? get description => _description;
  String? get link => _link;
  String? get address => _address;
  String? get date => _date;
  String? get image => _image;
  String? get doctorId => _doctorId;
  String? get docName => _docName;
  String? get docAddress => _docAddress;
  String? get docDegree => _docDegree;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['designation'] = _designation;
    map['status'] = _status;
    map['description'] = _description;
    map['link'] = _link;
    map['address'] = _address;
    map['date'] = _date;
    map['image'] = _image;
    map['doctor_id'] = _doctorId;
    map['doc_name'] = _docName;
    map['doc_address'] = _docAddress;
    map['doc_degree'] = _docDegree;
    map['profile_image'] = _profileImage;
    return map;
  }

}