class ValidationUtility {
  static String? loginValidateEmail(String email) {
    if (email.length <= 10 ||
        email.substring(email.length - 10) != "@gmail.com"){
      return "Invalid Email";
    }
    return null;
  }

  static String? loginValidatePassword(String password) {
    if(password.isEmpty) {
      return "Invalid Password";
    }
    return null;
  }
}
