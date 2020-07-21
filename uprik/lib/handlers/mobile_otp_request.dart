import 'package:http/http.dart' as http;
import 'dart:convert';

class MobileOtpHandler {
  // String mobileNumber;
  bool success;
  // List<dynamic> data;
  String mobile_number;
  String otp;
  String message;

  MobileOtpHandler();

  void fromJson(Map<String, dynamic> json) {
    if (json['success']) {
      this.success = json['success'];
      this.mobile_number = json['data'][0]['mobNo'];
      this.otp = json['data'][0]['otp'];
      this.message = json['message'];
    } else {
      this.success = json['success'];
      this.message = json['message'];
    }
  }

  bool get boolsuccess => this.success;
  String get mobNumber => this.mobile_number;
  String get Otp => this.otp;
}
