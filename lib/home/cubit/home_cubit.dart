import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../model/weather_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final String _apiKey = "4f91d3eddf8f65e751c92e3248d6006a";

  Future<WeatherModel> _fetchCurrentWeather(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather"
      "?q=$city&units=metric&appid=$_apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future _fetchHourlyForecast(String city) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast"
      "?q=$city&units=metric&appid=$_apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['list'];
    } else {
      throw Exception("Failed to load hourly forecast");
    }
  }

  Future<void> loadWeather(String city) async {
    emit(HomeLoading());

    try {
      final weatherData = await _fetchCurrentWeather(city);
      final hourly = await _fetchHourlyForecast(city);

      emit(Weather(climate: weatherData, hourlyList: hourly));
    } catch (e) {
      emit(HomeError("City not found"));
    }
  }
}
