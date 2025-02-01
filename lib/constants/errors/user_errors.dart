class UserErrors {
  static String error(UserErrorCodes code) {
    switch (code) {
      case UserErrorCodes.usernameNotFound:
        return "User with this username doesn't exists.";
      case UserErrorCodes.notConnected:
        return "You are not connected to the server. Please reconnect to the server";
      case UserErrorCodes.emptyUsername:
        return "Please enter the user's username to continue";
      case UserErrorCodes.userIdNotFound:
        return "User's ID not found.";
      case UserErrorCodes.error:
        return "There is something wrong. Please contact your IT";
      case UserErrorCodes.serverError:
        return "There was a problem in the server. Please try again later or report it to the IT team";
    }
  }
}

enum UserErrorCodes {
  error,
  emptyUsername,
  usernameNotFound,
  userIdNotFound,
  notConnected,
  serverError
}
