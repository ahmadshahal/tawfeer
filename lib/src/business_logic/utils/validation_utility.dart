class ValidationUtility {
  static String? validateEmail(String email) {
    if (email.length <= 10 ||
        email.substring(email.length - 10) != "@gmail.com"){
      return "Invalid Email";
    }
    return null;
  }

  static String? loginValidatePassword(String password) {
    if(password.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  static String? registerValidatePassword(String password) {
    if(password.isEmpty) {
      return "Password can't be empty";
    }
    else if(password.length < 5) {
      return "Password is too short";
    }
    else if(password.length > 50) {
      return "password is too long";
    }
    return null;
  }

  static String? registerFullName(String fullName) {
    if(fullName.isEmpty) {
      return "Full Name can't be empty";
    }
    return null;
  }

  static String? registerPhoneNumber(String phoneNumber) {
    if(phoneNumber.length != 9) {
      return "Invalid phone number";
    }
    return null;
  }

}
