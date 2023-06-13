/// response_code : "1"
/// message : "OTP sent success"
/// status : "success"
/// otp : 2669
/// mobile : "78945784150"

class SendOtp {
  SendOtp({
      String? responseCode, 
      String? message, 
      String? status, 
      num? otp, 
      String? mobile,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _otp = otp;
    _mobile = mobile;
}

  SendOtp.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _otp = json['otp'];
    _mobile = json['mobile'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  num? _otp;
  String? _mobile;
SendOtp copyWith({  String? responseCode,
  String? message,
  String? status,
  num? otp,
  String? mobile,
}) => SendOtp(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  otp: otp ?? _otp,
  mobile: mobile ?? _mobile,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  num? get otp => _otp;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['otp'] = _otp;
    map['mobile'] = _mobile;
    return map;
  }

}