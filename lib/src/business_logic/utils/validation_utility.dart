class ValidationUtility {

  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? validateEmail(String email) {
    if (email.isEmpty || (!emailRegExp.hasMatch(email))){
      return "Invalid Email";
    }
    return null;
  }

  static String? validateLoginPassword(String password) {
    if(password.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  static String? validateRegisterPassword(String password) {
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

  static String? validateRegisterFullName(String fullName) {
    if(fullName.isEmpty) {
      return "Full Name can't be empty";
    }
    return null;
  }

  static String? validateProductTitle(String title) {
    if(title.isEmpty) {
      return "Title can't be empty";
    }
    return null;
  }

  static String? validateProductCategory(String category) {
    if(category.isEmpty) {
      return "Category can't be empty";
    }
    return null;
  }

  static String? validateRegisterPhoneNumber(String phoneNumber) {
    if(phoneNumber.length != 9 || !ValidationUtility.isNumeric(phoneNumber)) {
      return "Invalid phone number";
    }
    return null;
  }

  static String? validateNumericField(String s) {
    if(s.isEmpty || !ValidationUtility.isNumeric(s)) {
      return "Invalid value";
    }
    return null;
  }

  static String? validateDate(String s) {
    if(s.isEmpty) {
      return "Date can't be empty";
    }
    return null;
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

}
