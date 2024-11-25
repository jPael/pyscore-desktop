import 'package:flutter/material.dart';

class Problems extends StatelessWidget {
  const Problems({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Thesis Writing'),
        ),
        body: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              print('Clicked!');
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CS 141 - Thesis Writing 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('4CSB'),
                  SizedBox(height: 10),
                  Text('Click to view', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
