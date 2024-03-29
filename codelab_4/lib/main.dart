import 'package:flutter/material.dart';
import 'components/weather_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(  
        brightness: Brightness.dark,   
      ),
      home: WeatherOverview(),
    );
  }
}
