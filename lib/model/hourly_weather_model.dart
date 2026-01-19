class HourlyWeather {
  final int time;
  final double temp;
  final String icon;

  HourlyWeather({required this.time, required this.temp, required this.icon});

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['dt'],
      temp: json['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
