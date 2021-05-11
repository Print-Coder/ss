//username validation
String userNameValidation(String value) {
  if (value.length < 3)
    return 'User Name have minmum 3 charecters';
  else
    return null;
}

String editAddressValidation(String value) {
  if (value.length < 1)
    return 'Please enter this field';
  else
    return null;
}

//otpValidation
String otpValidation(String value) {
  if (value.length < 6)
    return 'otp should  have 6 charecters';
  else
    return null;
}

String zipValidation(String value) {
  if (value.length < 6)
    return 'Pincode should  have 6 charecters';
  else
    return null;
}

//password validation
String passwordValidation(String value) {
  if (value.length < 3) {
    return "Please Enter correct password";
  } else {
    return null;
  }
}

//email validation
String emailValidation(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (emailValid) {
    return null;
  } else {
    return "Please Enter Correct Email";
  }
}

String phoneValidation(String phone) {
  if (phone.length < 10) {
    return "Phone number should be 10 digits";
  } else {
    return null;
  }
}
