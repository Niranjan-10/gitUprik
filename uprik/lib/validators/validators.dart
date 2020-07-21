import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';

class Validator {
  String email;
  String password;
  String mobile;

  Validator();
}

String validateEmail(String email) {
  if (EmailValidator.validate(email)) {
    return null;
  } else {
    return 'invalid email';
  }
}
