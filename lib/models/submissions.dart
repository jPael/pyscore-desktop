import 'package:pyscore/constants/errors/post_errors.dart';
import 'package:pyscore/constants/errors/user_errors.dart';
import 'package:pyscore/constants/types/user_type.dart';
import 'package:pyscore/data/post_data.dart';
import 'package:pyscore/data/user_data.dart';
import 'package:pyscore/fields/submissions_fields.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/services/post_services.dart';
import 'package:pyscore/services/user_services.dart';
import 'package:pyscore/utils/results.dart';

const String submissionsTableName = "Submissions";

class Submissions {
  String? id;
  final String filename;
  final String userId;
  final String postId;
  final bool isChecked;
  int? score;
  String? remarks;
  String? checker;
  String? createdAt;
  String? updatedAt;

  Submissions(
      {this.id,
      required this.userId,
      required this.postId,
      required this.filename,
      required this.isChecked,
      this.score,
      this.remarks,
      this.checker,
      this.createdAt,
      this.updatedAt});

  static Submissions fromJson(Map<String, Object?> json) {
    return Submissions(
        id: json[SubmissionsFields.id] as String,
        userId: json[SubmissionsFields.userId] as String,
        postId: json[SubmissionsFields.postId] as String,
        filename: json[SubmissionsFields.filename] as String,
        isChecked: json[SubmissionsFields.isChecked] as bool,
        score: json[SubmissionsFields.score] as int,
        remarks: json[SubmissionsFields.remarks] as String,
        checker: json[SubmissionsFields.checker] as String,
        createdAt: json[SubmissionsFields.createdAt] as String,
        updatedAt: json[SubmissionsFields.updatedAt] as String);
  }

  Future<UserResults> getUser(String userType) async {
    if (userType == UserType.student) {
      UserResults result = await fetchUserById(userId);

      return result;
    } else if (userType == UserType.teacher) {
      final User? student = await getUserById(userId);

      if (student == null) {
        return UserResults(success: false, error: UserErrorCodes.usernameNotFound);
      }

      return UserResults(success: true, user: student);
    }

    return UserResults(error: UserErrorCodes.error);
  }

  Future<PostResults> getPost(String userType) async {
    if (userType == UserType.student) {
      return await fetchPostById(postId);
    } else if (userType == UserType.teacher) {
      final Post? post = await getPostById(postId);

      if (post == null) {
        return PostResults(success: false, error: PostErrorCode.postNotFound);
      }

      return PostResults(success: true, post: post);
    }

    return PostResults(success: false, error: PostErrorCode.error);
  }

  Future<UserResults> getCheck(String userType) async {
    if (checker == null) {
      return UserResults(success: false, error: UserErrorCodes.emptyUsername);
    }

    if (userType == UserType.student) {
      return await fetchUserById(checker!);
    } else if (userType == UserType.teacher) {
      User? checkerUser = await getUserById(checker!);

      if (checkerUser == null) {
        return UserResults(success: false, error: UserErrorCodes.userIdNotFound);
      }

      return UserResults(success: true, user: checkerUser);
    }

    return UserResults(success: false, error: UserErrorCodes.error);
  }
}
