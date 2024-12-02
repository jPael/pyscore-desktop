class ClassroomErrors {
  static String error(ClassroomErrorCode code) {
    switch (code) {
      case ClassroomErrorCode.creationError:
        return "There was an error in creating the classroom. Please try again later";
      case ClassroomErrorCode.classroomNotFound:
        return "Classroom was not found";

      default:
        return "An unknown error occurred. Please try again later.";
    }
  }
}

enum ClassroomErrorCode { creationError, classroomNotFound }
