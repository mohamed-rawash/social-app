extension Validator on String {
  bool isValidEmail() {
    return RegExp(r'^[A-z0-9]+@(gmail|yahoo|hotmail)\.(com|org|info)')
        .hasMatch(this);
  }

  bool isValidUserName() {
    return RegExp(r'^[A-z0-9 -]')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }

  bool isValidPhoneNo() {
    return RegExp(r'^\+[0-9]{12}$')
        .hasMatch(this);
  }
}

extension StringCasing on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}