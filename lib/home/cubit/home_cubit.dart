import 'package:flutter_application_1/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/weather_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final WeatherService _service;

  HomeCubit(this._service) : super(HomeInitial());

  Future<WeatherModel> _getCurrentWeather(String city) async {
    return await _service.fetchCurrentWeather(city);
  }

  Future<List> _getHourlyList(String city) async {
    final data = await _service.fetchHourlyForecast(city);
    return data['list'];
  }

  Future<void> loadWeather(String city) async {
    emit(HomeInitial());

    try {
      final currentWeather = await _getCurrentWeather(city);
      final hourlyList = await _getHourlyList(city);

      emit(Weather(climate: currentWeather, hourlyList: hourlyList));
    } catch (e) {
      emit(HomeError("City not found. Try another city."));
    }
  }
}
