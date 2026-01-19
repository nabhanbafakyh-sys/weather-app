class WeatherModel {
  final double temp;
  final String condition;
  final int humidity;
  final double wind;
  final double feelsLike;
  final int pressure;

  WeatherModel({
    required this.temp,
    required this.condition,
    required this.humidity,
    required this.wind,
    required this.feelsLike,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      wind: json['wind']['speed'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }
}
