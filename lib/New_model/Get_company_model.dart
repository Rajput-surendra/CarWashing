/// status : true
/// message : "Companies lists"
/// data : [{"company_name":"Octopus Medical","id":"260"},{"company_name":"pharmcom","id":"261"},{"company_name":"sffs","id":"262"},{"company_name":"new","id":"263"}]

class GetCompanyModel {
  GetCompanyModel({
      bool? status, 
      String? message, 
      List<CompanyDataList>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCompanyModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CompanyDataList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CompanyDataList>? _data;
GetCompanyModel copyWith({  bool? status,
  String? message,
  List<CompanyDataList>? data,
}) => GetCompanyModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<CompanyDataList>? get data => _data;

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

/// company_name : "Octopus Medical"
/// id : "260"

class CompanyDataList {
  CompanyDataList({
      String? companyName, 
      String? id,}){
    _companyName = companyName;
    _id = id;
}

  CompanyDataList.fromJson(dynamic json) {
    _companyName = json['company_name'];
    _id = json['id'];
  }
  String? _companyName;
  String? _id;
CompanyDataList copyWith({  String? companyName,
  String? id,
}) => CompanyDataList(  companyName: companyName ?? _companyName,
  id: id ?? _id,
);
  String? get companyName => _companyName;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = _companyName;
    map['id'] = _id;
    return map;
  }

}