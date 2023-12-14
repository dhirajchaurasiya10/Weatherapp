import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_services.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('7a3e45e015553c837da32defc0d2698e');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    // get the current city
    String cityname = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //city name
          Text(_weather?.cityname ?? "Loading city.."),

          //temperature
          Text('${_weather?.temperature.round()}C')
        ],
      ),
    );
  }
}
