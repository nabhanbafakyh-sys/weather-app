import '../../model/weather_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class Weather extends HomeState {
  final WeatherModel climate;
  final List<dynamic> hourlyList;

  Weather({required this.climate, required this.hourlyList});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
