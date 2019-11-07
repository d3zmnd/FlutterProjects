import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  Weather(this.temperature, this.locationName, this.iconUrl);
  Weather.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'],
        locationName = json['name'],
        iconUrl = _generateIconUrl(json['weather'][0]['icon']);

  final int temperature;
  final String locationName;
  final String iconUrl;
  static String _generateIconUrl(String icon) =>'https://openweathermap.org/img/wn/$icon@2x.png';
}
class WeatherProvider {
Future<Weather> getCurrentWeather() async {
  final http.Response response = await http.get(
      'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975');
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
class WeatherContainer extends StatelessWidget {
  const WeatherContainer({Key key, @required this.weather})
      : assert(weather != null),
      super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) => 
      orientation == Orientation.portrait ? portrait(context) : landscape(context));
  }
  Widget portrait(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        text('${weather.locationName}  ${weather.temperature} °C', context),
        Image.network(weather.iconUrl),
      ],
    );
  }
  Widget landscape(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            text('${weather.locationName}', context),
            text('${weather.temperature} °C', context)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(weather.iconUrl),
          ],
        ),
      ],  
    );
  }
  dynamic text(String txt, dynamic context) {
    return Text(
      '$txt',
      style: Theme.of(context).textTheme.display1,
      textAlign: TextAlign.center,
    );
  }
}
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


