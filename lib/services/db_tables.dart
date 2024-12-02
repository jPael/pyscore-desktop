import 'package:pyscore/fields/post_fields.dart';
import 'package:pyscore/fields/user_classroom_fields.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/user.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/fields/user_fields.dart';
import 'package:pyscore/fields/classroom_fields.dart';

List<Map<String, String>> sqlTables = [
  {
    "tablename": userTableName,
    "query": '''
          CREATE TABLE $userTableName (
          ${UserFields.id} TEXT PRIMARY KEY,
          ${UserFields.studentId} Text UNIQUE ,
          ${UserFields.username} TEXT UNIQUE,
          ${UserFields.password} TEXT,
          ${UserFields.firstname} TEXT,
          ${UserFields.lastname} TEXT,
          ${UserFields.userType} TEXT,
          ${UserFields.createdAt} TEXT,
          ${UserFields.updatedAt} TEXT
          )
'''
  },
  {
    "tablename": classroomTableName,
    "query": '''
          CREATE TABLE $classroomTableName (
          ${ClassroomFields.id} TEXT PRIMARY KEY,
          ${ClassroomFields.name} TEXT UNIQUE,
          ${ClassroomFields.ownerId} TEXT, 
          ${ClassroomFields.createdAt} TEXT,
          ${ClassroomFields.updatedAt} TEXT,
          ${ClassroomFields.code} TEXT,
          FOREIGN KEY (${ClassroomFields.ownerId}) REFERENCES $userTableName(id)
          )
'''
  },
  {
    "tablename": postTableName,
    "query": '''
        CREATE TABLE $postTableName (
        ${PostFields.id} TEXT PRIMARY KEY,
        ${PostFields.title} TEXT,
        ${PostFields.instruction} TEXT,
        ${PostFields.points}  TEXT,
        ${PostFields.createdAt}  TEXT,
        ${PostFields.updatedAt}  TEXT,
        ${PostFields.duration}  TEXT,
        ${PostFields.due}  TEXT,
        ${PostFields.classId}  TEXT,
        
        FOREIGN KEY (${PostFields.classId}) REFERENCES $classroomTableName(id)
        )
'''
  },
  {
    "tablename": userClassroomTableName,
    "query": '''
        CREATE TABLE $userClassroomTableName (
        ${UserClassroomFields.userId} TEXT,
        ${UserClassroomFields.classroomId} TEXT,
        ${UserClassroomFields.createdAt} TEXT,
        ${UserClassroomFields.updatedAt} TEXT,
        PRIMARY KEY (${UserClassroomFields.userId}, ${UserClassroomFields.classroomId}),
        FOREIGN KEY (${UserClassroomFields.userId}) REFERENCES $userTableName(id),
        FOREIGN KEY (${UserClassroomFields.classroomId}) REFERENCES $classroomTableName(id))

'''
  }
];
