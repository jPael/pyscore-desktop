import 'package:flutter/material.dart';
import 'package:pyscore/models/posts.dart';

class Classroom {
  final String id;
  final String classroomName;
  final String section;
  final String owner;
  final List<Posts> posts;

  Classroom(this.id, this.classroomName, this.section, this.owner, this.posts);
}
