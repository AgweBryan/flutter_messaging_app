class Util {
  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String displayName) {
    final nameSplit = displayName.split(" ");
    final firstNameInitial = nameSplit[0][0];
    final lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }
}
