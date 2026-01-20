import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = "daf88a3bdcfefa23a6cdb8d42e3b9d9f";
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final cleanedCity = city.trim();

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather"
      "?q=$cleanedCity&units=metric&appid=$apiKey",
    );

    print("CURRENT URL: $url");

    final response = await http.get(url);

    print("CURRENT STATUS: ${response.statusCode}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("City not found");
    }
  }

  Future<Map<String, dynamic>> fetchHourlyForecast(String city) async {
    final cleanedCity = city.trim();

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast"
      "?q=$cleanedCity&units=metric&appid=$apiKey",
    );

    print("HOURLY URL: $url");

    final response = await http.get(url);

    print("HOURLY STATUS: ${response.statusCode}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Hourly forecast error");
    }
  }
}
