import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const DetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
