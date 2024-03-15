class Validator {
  Validator._();

  static String? validatorName(String? value) {
    final condition = RegExp(r"^[a-zA-ZÀ-ÿ\s']+(\s[a-zA-ZÀ-ÿ\s']+)*$");

    if (value != null && value.isEmpty) {
      return "This field cannot be empyt!";
    }
    if (value != null && !condition.hasMatch(value)) {
      return 'Invalid character in name.';
    }

    return null;
  }

  static String? validatorEmail(String? value) {
    final condition =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value != null && value.isEmpty) {
      return "This field cannot be empyt!";
    }
    if (value != null && !value.contains(condition)) {
      return 'Invalid character in name.';
    }

    return null;
  }

  static String? validatorPassword(String? value) {
    final condition =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value != null && value.isEmpty) {
      return "This field cannot be empyt!";
    }
    if (value != null && !value.contains(condition)) {
      return 'Invalid ';
    }

    return null;
  }
}
