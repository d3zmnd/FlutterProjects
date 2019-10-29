import 'package:flutter/material.dart';
import 'widgets/todo_list.dart';
import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        brightness: Brightness.dark,        
        accentColor: accentColor,
        highlightColor: accentColor,
        primaryColor: primaryColor,
       
      ),
      home: TodoList(),
    );
  }
}

