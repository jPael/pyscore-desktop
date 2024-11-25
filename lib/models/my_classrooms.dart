import 'package:flutter/material.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';

class MyClassrooms extends ChangeNotifier {
  final List<Classroom> _myClassrooms = [];

  List<Classroom> get myClassrooms => _myClassrooms;

  void createClassroom(Classroom classroom) {
    _myClassrooms.add(classroom);
    notifyListeners();
  }

  void createPost(Classroom classroom, Posts post) {
    final int index = _myClassrooms.indexWhere((c) => c.id == classroom.id);

    final List<Posts> _p = _myClassrooms[index].posts;

    _p.add(post);

    _myClassrooms[index] = Classroom(classroom.id, classroom.classroomName,
        classroom.section, classroom.owner, _p);

    notifyListeners();
  }
}
