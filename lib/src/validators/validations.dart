class Validations {
  static bool isValidUser(String user) {
    return user != '';
  }

  static int isValidPass(String pass) {
    if (pass == '') {
      return 0;
    } else if (pass.length < 6) {
      return 1;
    }
    return 2;
  }
}
