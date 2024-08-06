bool isValidEmailFormat(String email) {
  // Define the regex for validating an email
  String pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}
