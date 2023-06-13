class UserRegistrationModel {
  String? responseCode;
  String? message;
  String? status;
  bool? user;
  Null? otp;

  UserRegistrationModel(
      {this.responseCode, this.message, this.status, this.user, this.otp});

  UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    user = json['user'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    data['user'] = this.user;
    data['otp'] = this.otp;
    return data;
  }
}