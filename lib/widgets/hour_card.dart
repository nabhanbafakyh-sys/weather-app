import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherCard extends StatelessWidget {
  final Map hour;
  final bool isSelected;
  final VoidCallback onTap;

  const HourlyWeatherCard({
    super.key,
    required this.hour,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000);
    final time = DateFormat.j().format(date);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        margin: const EdgeInsets.only(right: 25),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(color: isSelected ? Colors.black : Colors.grey),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${hour['weather'][0]['icon']}@2x.png",
              width: 40,
            ),
            Text(
              "${hour['main']['temp'].round()}°",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
