import 'package:flutter/material.dart';
import 'components/gallery.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: 'Flutter Gallery',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.indigo,
        
      ),
      home: DefaultTabController(
        length: 2,
        child: MyHomePage(),
      ),
    );
  
}
