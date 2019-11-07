import 'package:flutter/material.dart';
import 'package:weather_app/components/weather_container.dart';

class WeatherOverview extends StatelessWidget {
final WeatherProvider _weatherProvider = WeatherProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather')
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _weatherProvider.getCurrentWeather(),
          builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
            if (snapshot.hasData) {
              return WeatherContainer(weather: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


