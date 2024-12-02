import 'package:flutter/material.dart';
import 'package:pyscore/data/classroom_data.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/models/user.dart';

class MyClassrooms extends ChangeNotifier {
  String? userId;
  List<Classroom> _myClassrooms = [];

  List<Classroom> get myClassrooms => _myClassrooms;

  MyClassrooms() {
    initializeData();
  }

  void setId(String? id) {
    if (id == null || id.isEmpty) return;

    userId = id;

    initializeData();
  }

  void initializeData() async {
    if (userId == null) {
      return;
    }

    try {
      // ignore: no_leading_underscores_for_local_identifiers
      List<Classroom> fetchedClassroom =
          await getAllClassroomByOwnerId(userId!);

      if (fetchedClassroom.isEmpty) return;

      _myClassrooms = fetchedClassroom;
      notifyListeners();
    } catch (e, stackTrace) {
      print("Error initializing data: $e");
      print(stackTrace);
    }
  }

  void createClassroom(Classroom classroom) {
    _myClassrooms.add(classroom);
    notifyListeners();
  }

  void createPost(Classroom classroom, Post post) {
    final int index = _myClassrooms.indexWhere((c) => c.id == classroom.id);

    // ignore: no_leading_underscores_for_local_identifiers
    final List<Post> _p = [...?_myClassrooms[index].posts, post];

    _myClassrooms[index] = _myClassrooms[index].copyWith(posts: _p);

    notifyListeners();
  }
}
