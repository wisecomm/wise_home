import 'package:flutter/material.dart';

class WorkListDetail extends StatelessWidget {
  // Declare a field that holds the Todo
  final String description;

  // In the constructor, require a Todo
  const WorkListDetail({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = '리스트 Detail';

    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      ),
    );
  }
}
