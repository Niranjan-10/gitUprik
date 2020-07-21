class OtpValidation {
  String message;
  bool success;
  OtpValidation();

  void fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.success = json['success'];
  }
}
