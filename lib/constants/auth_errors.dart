class Autherrors {
  static String error(AuthErrorCode code) {
    switch (code) {
      case AuthErrorCode.userNotFound:
        return "Username does not exist";
      case AuthErrorCode.wrongPassword:
        return "Wrong password";

      case AuthErrorCode.serverError:
        return "There was a problem on the server. Please try again next time";

      default:
        return "An unknown error occurred. Please try again later.";
    }
  }
}

enum AuthErrorCode { userNotFound, serverError, wrongPassword }
