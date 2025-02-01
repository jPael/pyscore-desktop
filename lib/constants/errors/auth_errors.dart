class Autherrors {
  static String error(AuthErrorCode code) {
    switch (code) {
      case AuthErrorCode.userNotFound:
        return "Username does not exist";
      case AuthErrorCode.wrongPassword:
        return "Wrong password";

      case AuthErrorCode.serverError:
        return "There was a problem on the server. Please try again next time";
      case AuthErrorCode.unspecifiedUserType:
        return "No user specification";
      case AuthErrorCode.unableToSignUp:
        return "Unable to register the user. Please try again";
      case AuthErrorCode.notConnectedToServer:
        return "You are not connected to a server. Please connect first and try again";
      case AuthErrorCode.studentNotFound:
        return "Student doesn't exist";
    }
  }
}

enum AuthErrorCode {
  userNotFound,
  serverError,
  wrongPassword,
  unspecifiedUserType,
  studentNotFound,
  unableToSignUp,
  notConnectedToServer
}
