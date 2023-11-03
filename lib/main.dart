import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  final String jsonWeatherData = '''
  [
    {
      "city": "New York",
      "temperature": 20,
      "condition": "Clear",
      "humidity": 60,
      "windSpeed": 5.5
    },
    {
      "city": "Los Angeles",
      "temperature": 25,
      "condition": "Sunny",
      "humidity": 50,
      "windSpeed": 6.8
    },
    {
      "city": "London",
      "temperature": 15,
      "condition": "Partly Cloudy",
      "humidity": 70,
      "windSpeed": 4.2
    },
    {
      "city": "Tokyo",
      "temperature": 28,
      "condition": "Rainy",
      "humidity": 75,
      "windSpeed": 8.0
    },
    {
      "city": "Sydney",
      "temperature": 22,
      "condition": "Cloudy",
      "humidity": 55,
      "windSpeed": 7.3
    }
  ]
  ''';

  @override
  Widget build(BuildContext context) {
    List<WeatherData> weatherDataList = List<WeatherData>.from(json.decode(jsonWeatherData).map((data) => WeatherData.fromJson(data)));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Info App'),
        ),
        body: ListView.builder(
          itemCount: weatherDataList.length,
          itemBuilder: (context, index) {
            WeatherData weatherData = weatherDataList[index];
            return WeatherCard(weatherData: weatherData);
          },
        ),
      ),
    );
  }
}

class WeatherData {
  final String city;
  final int temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'].toDouble(),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('City: ${weatherData.city}',style: const TextStyle(fontSize: 20),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${weatherData.temperature}°C'),
            Text('Condition: ${weatherData.condition}'),
            Text('Humidity: ${weatherData.humidity}%'),
            Text('Wind Speed: ${weatherData.windSpeed} m/s'),
          ],
        ),
      ),
    );
  }
}
