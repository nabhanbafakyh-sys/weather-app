part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class Weather extends HomeState {
  final WeatherModel climate;
  final List hourlyList;

  Weather({required this.climate, required this.hourlyList});
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
