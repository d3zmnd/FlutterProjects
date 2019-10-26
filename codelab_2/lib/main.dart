import 'package:flutter/material.dart';
import 'widgets/todo_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        brightness: Brightness.dark,        
        accentColor: Colors.lightBlue[300],
        highlightColor: Colors.lightBlue[800],
        primaryColor: Colors.black,
       
      ),
      home: TodoList(),
    );
  }
}

