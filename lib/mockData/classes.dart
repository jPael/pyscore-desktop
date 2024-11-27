class Classes {
  List<Map<String, dynamic>> classData = [
    {
      "id": "1",
      "classroomName": "Python 101",
      "section": "A",
      "owner": "Catherine Alimboyong",
      "posts": [
        {
          "id": "1",
          "title": "Build a Flutter Todo App",
          "instructions":
              "Create a simple todo application with add, edit, and delete functionality using Flutter.",
          "class": "Mobile Development",
          "points": 100,
          "due": DateTime.parse("2024-11-30 23:59:59"),
          "createdAt": DateTime.now(),
          "updatedAt": DateTime.now(),
        },
        {
          "id": "2",
          "title": "Implement Bubble Sort",
          "instructions":
              "Write a program to implement the bubble sort algorithm in any programming language of your choice.",
          "class": "Data Structures and Algorithms",
          "points": 50,
          "due": DateTime.parse("2024-12-05 23:59:59"),
          "createdAt": DateTime.now(),
          "updatedAt": DateTime.now(),
        },
        {
          "id": "3",
          "title": "Set Up a Node.js Server",
          "instructions":
              "Create a basic Node.js server that responds with 'Hello, World!' when accessed via a browser. Create a basic Node.js server that responds with 'Hello, World!' when accessed via a browser. Create a basic Node.js server that responds with 'Hello, World!' when accessed via a browser.",
          "class": "Backend Development",
          "points": 75,
          "due": DateTime.parse("2024-12-01 23:59:59"),
          "createdAt": DateTime.now(),
          "updatedAt": DateTime.now(),
        },
      ]
    },
    {
      "id": "2",
      "classroomName": "Web Development",
      "section": "B",
      "owner": "Melbrick Alba Evallar",
    },
    {
      "id": "3",
      "classroomName": "Data Science with Python and Visual Basic's .NET",
      "section": "C",
      "owner": "Coravil Joy Avila",
    },
  ];
}
