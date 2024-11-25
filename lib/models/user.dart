class User {
  final String firstname;
  final String lastname;
  final String section;
  final String studentId;
  final String password;
  final String userType;

  User(
    this.firstname,
    this.lastname,
    this.section,
    this.studentId,
    this.password,
    this.userType,
  );

  Map<String, dynamic> get getUserInfo => {
        "firstname": firstname,
        "lastname": lastname,
        "section": section,
        "studentId": studentId,
        "userType": userType
      };
}
