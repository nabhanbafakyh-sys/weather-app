// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  cityName: json['cityName'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  feelsLike: (json['feelsLike'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
  pressure: (json['pressure'] as num).toInt(),
  windSpeed: (json['windSpeed'] as num).toDouble(),
  condition: json['condition'] as String,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'condition': instance.condition,
      'icon': instance.icon,
    };
