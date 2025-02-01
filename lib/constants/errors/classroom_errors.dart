class ClassroomErrors {
  static String error(ClassroomErrorCode code) {
    switch (code) {
      case ClassroomErrorCode.creationError:
        return "There was an error in creating the classroom. Please try again later";
      case ClassroomErrorCode.classroomNotFound:
        return "Classroom was not found";
      case ClassroomErrorCode.codeDoesntExists:
        return "Classroom code doesn't exists";
      case ClassroomErrorCode.classroomJoinError:
        return "There was an error joining this classroom";
      case ClassroomErrorCode.notConnectedToTheServer:
        return "You are not connected to the server. Please log out and connect to the server then try again.";
      case ClassroomErrorCode.serverError:
        return "An unknown error occurred. Please try again later.";
      case ClassroomErrorCode.classroomCodeIsEmpty:
        return "Please input a classroom code";
    }
  }
}

enum ClassroomErrorCode {
  classroomCodeIsEmpty,
  creationError,
  classroomNotFound,
  codeDoesntExists,
  classroomJoinError,
  notConnectedToTheServer,
  serverError
}
