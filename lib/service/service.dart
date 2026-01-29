import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherService {
  final String _apiKey = "4f91d3eddf8f65e751c92e3248d6006a";

  Future<WeatherModel> fetchCurrentWeather(String city) async {
    final cleanedCity = city.trim();

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather"
      "?q=$cleanedCity&units=metric&appid=$_apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<Map<String, dynamic>> fetchHourlyForecast(String city) async {
    final cleanedCity = city.trim();

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast"
      "?q=$cleanedCity&units=metric&appid=$_apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load hourly forecast");
    }
  }
}
