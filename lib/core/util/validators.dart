import 'package:email_validator/email_validator.dart';

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length > 20) {
    return "Too long";
  }
  return null;
}


String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (!EmailValidator.validate(value)) {
    return "Invalid Email";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "This field cannot be empty";
  } else if (value.length < 5) {
    return "Password should be longer than 4 characters";
  }
  return null;
}

