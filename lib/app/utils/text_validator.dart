class TextFieldValidator {
  static String? name(String? value) {
    if (value == null) return 'Enter your name';
    value = value.trim();
    if (value.length == 0) {
      return 'Enter your name';
    } else if (value.length < 3) {
      return 'Min 3 symbols';
    } else if (value.length > 120) {
      return "Max 120 symbols";
    }
    return null;
  }

  static String? userName(String? value) {
    if (value == null) return 'Enter your nickname';
    value = value.trim();
    if (value.length == 0) {
      return 'Enter your nickname';
    } else if (value.length < 3) {
      return 'Min 3 symbols';
    } else if (value.length > 30) {
      return "Max 30 symbols";
    }
    return null;
  }

  static String? about(String value) {
    return value.length > 800 ? "Max - 800 symbols" : null;
  }

  static String? title(String value) {
    return value.length < 2 ? "Title should contain at least 2 symbols" : null;
  }

  static String? password(String? value) {
    if (value == null) return "Enter password";
    value = value.trim();
    if (value.length == 0) return "Enter password";
    if (passwordComplexity(value) < 2)
      return "Least 6 characters long, contain digit and special characters";
    return null;
  }

  static String? email(String? value) {
    if (value == null) return "Enter Email";
    value = value.trim();
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailValid) {
      return 'Invalid Email';
    }
    return null;
  }

  static int passwordComplexity(String value) {
    int complexity = 0;
    if (value.length >= 6) {
      bool hasUppercase = value.contains(new RegExp(r'[A-Z]'));
      bool hasDigits = value.contains(new RegExp(r'[0-9]'));
      bool hasLowercase = value.contains(new RegExp(r'[a-z]'));
      bool hasSpecialCharacters =
          value.contains(new RegExp(r'[!@#$%^&*+(),.?":{}|<>]'));

      if (hasLowercase) complexity += 1;
      if (hasUppercase) complexity += 1;
      if (hasDigits) complexity += 1;
      if (hasSpecialCharacters) complexity += 1;
      if (hasLowercase && hasUppercase && complexity == 2)
        complexity = 1; //MTUB-248
    }

    return complexity;
  }
}
