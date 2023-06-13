/// error : false
/// message : "All Awareness Lists"
/// data : {"poster":[{"user_name":"Shashank Saxena","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"MAHARAJA YESHWANT RAO HOSPITAL,INDORE ; Address, M.Y. Hospital, Indore","user_phone":"7828876950","user_digree":"M.B.B.S","id":"16","title":"test","aware_input":"poster","aware_language":"assam","date":"2023-04-06 12:51:50","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg","status":"1","pharma_id":"42","type":"doctor-awareness","is_fav":false},{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"12","title":"atatatata","aware_input":"poster","aware_language":"bengali","date":"2023-04-10 15:21:18","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":false}],"leaflets":[{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"13","title":"dedemdoed","aware_input":"leaflets","aware_language":"hindi","date":"2023-03-31 16:44:38","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/6426996853359.jpg","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":false},{"user_name":"gautamatul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"ytutut","user_phone":"7978778787","user_digree":null,"id":"7","title":"demo","aware_input":"leaflets","aware_language":"kanada","date":"2023-04-06 18:29:15","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","pharma_id":"98","status":"1","type":"pharma-awareness","is_fav":false}],"booklets":[{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"18","title":"its fine","aware_input":"booklets","aware_language":"bengali","date":"2023-04-10 15:23:15","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135509_087.jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":true},{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"11","title":"deded","aware_input":"booklets","aware_language":"hindi","date":"2023-04-10 15:21:20","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(59).jpg","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":true}],"m-poster":[{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"19","title":"super Liine poster","aware_input":"m-poster","aware_language":"hindi","date":"2023-04-10 15:23:14","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135056_991.jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":true}],"video":[{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"22","title":"Multi Talented View","aware_input":"video","aware_language":"Marathi","date":"2023-04-11 15:42:31","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/6434f4800362c.png","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":false},{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"17","title":"adsfsdfsd","aware_input":"video","aware_language":"assam","date":"2023-04-06 18:22:22","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/file_example_MP4_480_1_5MG1.mp4","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":false}]}

class GetSearchModel {
  GetSearchModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetSearchModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetSearchModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetSearchModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// poster : [{"user_name":"Shashank Saxena","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"MAHARAJA YESHWANT RAO HOSPITAL,INDORE ; Address, M.Y. Hospital, Indore","user_phone":"7828876950","user_digree":"M.B.B.S","id":"16","title":"test","aware_input":"poster","aware_language":"assam","date":"2023-04-06 12:51:50","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg","status":"1","pharma_id":"42","type":"doctor-awareness","is_fav":false},{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"12","title":"atatatata","aware_input":"poster","aware_language":"bengali","date":"2023-04-10 15:21:18","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":false}]
/// leaflets : [{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"13","title":"dedemdoed","aware_input":"leaflets","aware_language":"hindi","date":"2023-03-31 16:44:38","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/6426996853359.jpg","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":false},{"user_name":"gautamatul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"ytutut","user_phone":"7978778787","user_digree":null,"id":"7","title":"demo","aware_input":"leaflets","aware_language":"kanada","date":"2023-04-06 18:29:15","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","pharma_id":"98","status":"1","type":"pharma-awareness","is_fav":false}]
/// booklets : [{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"18","title":"its fine","aware_input":"booklets","aware_language":"bengali","date":"2023-04-10 15:23:15","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135509_087.jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":true},{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"11","title":"deded","aware_input":"booklets","aware_language":"hindi","date":"2023-04-10 15:21:20","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(59).jpg","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":true}]
/// m-poster : [{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"19","title":"super Liine poster","aware_input":"m-poster","aware_language":"hindi","date":"2023-04-10 15:23:14","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135056_991.jpg","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":true}]
/// video : [{"user_name":"Shivansh Shukla","user_image":"https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg","user_address":"dbjdhehbbsNZmgmdmgf","user_phone":"6868635538","user_digree":"B- Pharma","id":"22","title":"Multi Talented View","aware_input":"video","aware_language":"Marathi","date":"2023-04-11 15:42:31","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/6434f4800362c.png","status":"1","pharma_id":"49","type":"doctor-awareness","is_fav":false},{"user_name":"Atul","user_image":"https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png","user_address":"fjghj","user_phone":"98798798778","user_digree":"jhgdfjhg","id":"17","title":"adsfsdfsd","aware_input":"video","aware_language":"assam","date":"2023-04-06 18:22:22","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/file_example_MP4_480_1_5MG1.mp4","status":"1","pharma_id":"47","type":"doctor-awareness","is_fav":false}]

class Data {
  Data({
      List<Poster>? poster, 
      List<Leaflets>? leaflets, 
      List<Booklets>? booklets, 
      List<MPoster>? mposter, 
      List<Video>? video,}){
    _poster = poster;
    _leaflets = leaflets;
    _booklets = booklets;
    _mposter = mposter;
    _video = video;
}

  Data.fromJson(dynamic json) {
    if (json['poster'] != null) {
      _poster = [];
      json['poster'].forEach((v) {
        _poster?.add(Poster.fromJson(v));
      });
    }
    if (json['leaflets'] != null) {
      _leaflets = [];
      json['leaflets'].forEach((v) {
        _leaflets?.add(Leaflets.fromJson(v));
      });
    }
    if (json['booklets'] != null) {
      _booklets = [];
      json['booklets'].forEach((v) {
        _booklets?.add(Booklets.fromJson(v));
      });
    }
    if (json['m-poster'] != null) {
      _mposter = [];
      json['m-poster'].forEach((v) {
        _mposter?.add(MPoster.fromJson(v));
      });
    }
    if (json['video'] != null) {
      _video = [];
      json['video'].forEach((v) {
        _video?.add(Video.fromJson(v));
      });
    }
  }
  List<Poster>? _poster;
  List<Leaflets>? _leaflets;
  List<Booklets>? _booklets;
  List<MPoster>? _mposter;
  List<Video>? _video;
Data copyWith({  List<Poster>? poster,
  List<Leaflets>? leaflets,
  List<Booklets>? booklets,
  List<MPoster>? mposter,
  List<Video>? video,
}) => Data(  poster: poster ?? _poster,
  leaflets: leaflets ?? _leaflets,
  booklets: booklets ?? _booklets,
  mposter: mposter ?? _mposter,
  video: video ?? _video,
);
  List<Poster>? get poster => _poster;
  List<Leaflets>? get leaflets => _leaflets;
  List<Booklets>? get booklets => _booklets;
  List<MPoster>? get mposter => _mposter;
  List<Video>? get video => _video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_poster != null) {
      map['poster'] = _poster?.map((v) => v.toJson()).toList();
    }
    if (_leaflets != null) {
      map['leaflets'] = _leaflets?.map((v) => v.toJson()).toList();
    }
    if (_booklets != null) {
      map['booklets'] = _booklets?.map((v) => v.toJson()).toList();
    }
    if (_mposter != null) {
      map['m-poster'] = _mposter?.map((v) => v.toJson()).toList();
    }
    if (_video != null) {
      map['video'] = _video?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_name : "Shivansh Shukla"
/// user_image : "https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg"
/// user_address : "dbjdhehbbsNZmgmdmgf"
/// user_phone : "6868635538"
/// user_digree : "B- Pharma"
/// id : "22"
/// title : "Multi Talented View"
/// aware_input : "video"
/// aware_language : "Marathi"
/// date : "2023-04-11 15:42:31"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/6434f4800362c.png"
/// status : "1"
/// pharma_id : "49"
/// type : "doctor-awareness"
/// is_fav : false

class Video {
  Video({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? status, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _status = status;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Video.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _status = json['status'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _status;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Video copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? status,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Video(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  status: status ?? _status,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get status => _status;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['status'] = _status;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "Atul"
/// user_image : "https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png"
/// user_address : "fjghj"
/// user_phone : "98798798778"
/// user_digree : "jhgdfjhg"
/// id : "19"
/// title : "super Liine poster"
/// aware_input : "m-poster"
/// aware_language : "hindi"
/// date : "2023-04-10 15:23:14"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135056_991.jpg"
/// status : "1"
/// pharma_id : "47"
/// type : "doctor-awareness"
/// is_fav : true

class MPoster {
  MPoster({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? status, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _status = status;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  MPoster.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _status = json['status'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _status;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
MPoster copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? status,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => MPoster(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  status: status ?? _status,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get status => _status;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['status'] = _status;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "Atul"
/// user_image : "https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png"
/// user_address : "fjghj"
/// user_phone : "98798798778"
/// user_digree : "jhgdfjhg"
/// id : "18"
/// title : "its fine"
/// aware_input : "booklets"
/// aware_language : "bengali"
/// date : "2023-04-10 15:23:15"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_-_2023-04-07T135509_087.jpg"
/// status : "1"
/// pharma_id : "47"
/// type : "doctor-awareness"
/// is_fav : true

class Booklets {
  Booklets({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? status, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _status = status;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Booklets.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _status = json['status'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _status;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Booklets copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? status,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Booklets(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  status: status ?? _status,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get status => _status;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['status'] = _status;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "Shivansh Shukla"
/// user_image : "https://alphawizzserver.com/car_wash/istockphoto-1095468748-612x612.jpg"
/// user_address : "dbjdhehbbsNZmgmdmgf"
/// user_phone : "6868635538"
/// user_digree : "B- Pharma"
/// id : "13"
/// title : "dedemdoed"
/// aware_input : "leaflets"
/// aware_language : "hindi"
/// date : "2023-03-31 16:44:38"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/6426996853359.jpg"
/// status : "1"
/// pharma_id : "49"
/// type : "doctor-awareness"
/// is_fav : false

class Leaflets {
  Leaflets({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? status, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _status = status;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Leaflets.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _status = json['status'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _status;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Leaflets copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? status,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Leaflets(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  status: status ?? _status,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get status => _status;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['status'] = _status;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}

/// user_name : "Shashank Saxena"
/// user_image : "https://alphawizzserver.com/car_wash/uploads/user_image/no-image.png"
/// user_address : "MAHARAJA YESHWANT RAO HOSPITAL,INDORE ; Address, M.Y. Hospital, Indore"
/// user_phone : "7828876950"
/// user_digree : "M.B.B.S"
/// id : "16"
/// title : "test"
/// aware_input : "poster"
/// aware_language : "assam"
/// date : "2023-04-06 12:51:50"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg"
/// status : "1"
/// pharma_id : "42"
/// type : "doctor-awareness"
/// is_fav : false

class Poster {
  Poster({
      String? userName, 
      String? userImage, 
      String? userAddress, 
      String? userPhone, 
      String? userDigree, 
      String? id, 
      String? title, 
      String? awareInput, 
      String? awareLanguage, 
      String? date, 
      String? image, 
      String? status, 
      String? pharmaId, 
      String? type, 
      bool? isFav,}){
    _userName = userName;
    _userImage = userImage;
    _userAddress = userAddress;
    _userPhone = userPhone;
    _userDigree = userDigree;
    _id = id;
    _title = title;
    _awareInput = awareInput;
    _awareLanguage = awareLanguage;
    _date = date;
    _image = image;
    _status = status;
    _pharmaId = pharmaId;
    _type = type;
    _isFav = isFav;
}

  Poster.fromJson(dynamic json) {
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _userAddress = json['user_address'];
    _userPhone = json['user_phone'];
    _userDigree = json['user_digree'];
    _id = json['id'];
    _title = json['title'];
    _awareInput = json['aware_input'];
    _awareLanguage = json['aware_language'];
    _date = json['date'];
    _image = json['image'];
    _status = json['status'];
    _pharmaId = json['pharma_id'];
    _type = json['type'];
    _isFav = json['is_fav'];
  }
  String? _userName;
  String? _userImage;
  String? _userAddress;
  String? _userPhone;
  String? _userDigree;
  String? _id;
  String? _title;
  String? _awareInput;
  String? _awareLanguage;
  String? _date;
  String? _image;
  String? _status;
  String? _pharmaId;
  String? _type;
  bool? _isFav;
Poster copyWith({  String? userName,
  String? userImage,
  String? userAddress,
  String? userPhone,
  String? userDigree,
  String? id,
  String? title,
  String? awareInput,
  String? awareLanguage,
  String? date,
  String? image,
  String? status,
  String? pharmaId,
  String? type,
  bool? isFav,
}) => Poster(  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  userAddress: userAddress ?? _userAddress,
  userPhone: userPhone ?? _userPhone,
  userDigree: userDigree ?? _userDigree,
  id: id ?? _id,
  title: title ?? _title,
  awareInput: awareInput ?? _awareInput,
  awareLanguage: awareLanguage ?? _awareLanguage,
  date: date ?? _date,
  image: image ?? _image,
  status: status ?? _status,
  pharmaId: pharmaId ?? _pharmaId,
  type: type ?? _type,
  isFav: isFav ?? _isFav,
);
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get userAddress => _userAddress;
  String? get userPhone => _userPhone;
  String? get userDigree => _userDigree;
  String? get id => _id;
  String? get title => _title;
  String? get awareInput => _awareInput;
  String? get awareLanguage => _awareLanguage;
  String? get date => _date;
  String? get image => _image;
  String? get status => _status;
  String? get pharmaId => _pharmaId;
  String? get type => _type;
  bool? get isFav => _isFav;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['user_address'] = _userAddress;
    map['user_phone'] = _userPhone;
    map['user_digree'] = _userDigree;
    map['id'] = _id;
    map['title'] = _title;
    map['aware_input'] = _awareInput;
    map['aware_language'] = _awareLanguage;
    map['date'] = _date;
    map['image'] = _image;
    map['status'] = _status;
    map['pharma_id'] = _pharmaId;
    map['type'] = _type;
    map['is_fav'] = _isFav;
    return map;
  }

}