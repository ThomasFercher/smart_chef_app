library auth_process_state;

enum EmailValidation {
  valid,
  invalid,
  empty,
  none;

  String? get errorMessage {
    switch (this) {
      case EmailValidation.valid:
        return null;
      case EmailValidation.invalid:
        return "Invalid email";
      case EmailValidation.empty:
        return "Email is required";
      case EmailValidation.none:
        return null;
    }
  }
}

enum PasswordValidation {
  valid,
  toShort,
  toLong,
  noNumberAndSpecialChar,
  empty,
  none;

  String? get errorMessage {
    switch (this) {
      case PasswordValidation.valid:
        return null;
      case PasswordValidation.toShort:
        return "Password must be at least 8 characters";
      case PasswordValidation.noNumberAndSpecialChar:
        return "Password must contain at least one number and one special character";
      case PasswordValidation.empty:
        return "Password is required";
      case PasswordValidation.toLong:
        return "Password must be at most 64 characters";
      case PasswordValidation.none:
        return null;
    }
  }
}

EmailValidation validateEmail(String email) {
  if (email.isEmpty) {
    return EmailValidation.empty;
  }
  final RegExp regex = RegExp(
    r"^[\w!#$%&'*+/=?`{|}~^-]+(?:\.[\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}$",
  );
  if (!regex.hasMatch(email)) return EmailValidation.invalid;

  return EmailValidation.valid;
}

PasswordValidation validatePassword(String password) {
  if (password.isEmpty) return PasswordValidation.empty;
  if (password.length < 8) return PasswordValidation.toShort;
  if (password.length > 64) return PasswordValidation.toLong;

  final RegExp numberSpecialChar = RegExp(
    r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).+$',
  );

  if (!numberSpecialChar.hasMatch(password)) {
    return PasswordValidation.noNumberAndSpecialChar;
  }

  return PasswordValidation.valid;
}
