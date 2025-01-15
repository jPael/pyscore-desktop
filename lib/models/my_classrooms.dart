import 'package:flutter/foundation.dart';
import 'package:pyscore/models/classroom.dart';
import 'package:pyscore/models/posts.dart';
import 'package:pyscore/services/classroom_services.dart';

class MyClassrooms extends ChangeNotifier {
  // Singleton instance
  static final MyClassrooms _instance = MyClassrooms._internal();

  // Factory constructor for singleton
  factory MyClassrooms() {
    return _instance;
  }

  // Private named constructor
  MyClassrooms._internal() {
    _initializeData();
  }

  String? userId;
  String? userType;
  List<Classroom> _myClassrooms = [];

  List<Classroom> get myClassrooms => _myClassrooms;

  // Initialize user data
  void initUser(String id, String type) {
    if (id.isEmpty) return;

    if (userId == null) {
      userId = id;
      userType = type;

      _initializeData();
    }
  }

  // Fetch data from the server
  Future<void> _initializeData() async {
    if (userId == null) {
      return;
    }

    try {
      List<Classroom?> fetchedClassroom = await getAllClassroomByUserId(userId!, userType!);

      // print("fetched classsroom: ${fetchedClassroom.length}");

      _myClassrooms = fetchedClassroom.where((e) => e != null).cast<Classroom>().toList();

      // print("my classrooms length: ${_myClassrooms.length}");

      notifyListeners();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error initializing data: $e");
        print(stackTrace);
      }
    }
  }

  // Public method to refetch data
  void refetchData() => _initializeData();

  // Add a classroom
  void createClassroom(Classroom classroom) {
    _myClassrooms.add(classroom);
    notifyListeners();
  }

  // Delete a classroom
  void deleteClassroom(String id) {
    _myClassrooms.removeWhere((classroom) => classroom.id == id);
    notifyListeners();
  }

  // Create a post in a classroom
  void createPost(Classroom classroom, Post post) {
    final int index = _myClassrooms.indexWhere((c) => c.id == classroom.id);

    final List<Post> updatedPosts = [...?_myClassrooms[index].posts, post];

    _myClassrooms[index] = _myClassrooms[index].copyWith(posts: updatedPosts);

    notifyListeners();
  }
}
