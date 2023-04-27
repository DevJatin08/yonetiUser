class Validators {
  static String? validateAmount(String? str) {
    if (str!.isEmpty) {
      return 'Amount field is Required';
    } else if (str.startsWith('0')) {
      return 'Please enter valid amount';
    }
    return null;
  }

 

  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile Number field is Required";
    } else if (value.length != 10) {
      return "Please enter a valid Mobile Number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Email ID field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid Email ID";
    }
    return null;
  }

  static validatePassword(String? value) {
    String pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!+=_#^%*?&])([a-zA-Z0-9@$!+=_#^%*?&]{8,})$';

    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Password field is Required";
    } else if (value.length < 4) {
      return "Password should be more than 4 characters";
    } else if (!regExp.hasMatch(value)) {
      return "Password must contain eight characters,one capital letter,\none number and one special character";
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return "First name field is required";
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Last name field is required";
    }
    return null;
  }

  static String? validatePinCode(String? value) {
    if (value!.isEmpty) {
      return "Pin Code field is Required";
    } else if (value.length < 6) {
      return "Please enter a valid Pin Code";
    }
    return null;
  }






}
