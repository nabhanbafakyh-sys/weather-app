import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherCard extends StatefulWidget {
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
  State<HourlyWeatherCard> createState() => _HourlyWeatherCardState();
}

class _HourlyWeatherCardState extends State<HourlyWeatherCard> {
  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(widget.hour['dt'] * 1000);
    final time = DateFormat.j().format(date);

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        margin: const EdgeInsets.only(right: 25),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                color: widget.isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${widget.hour['weather'][0]['icon']}@2x.png",
              width: 40,
            ),
            Text(
              "${widget.hour['main']['temp'].round()}°",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
