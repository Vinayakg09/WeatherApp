import 'dart:ffi';

import 'package:flutter/material.dart';

class ForeCastwidget extends StatelessWidget {
  final String time;
  final IconData icon;
  final double? temp;
  const ForeCastwidget({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                icon,
                size: 30,
              ),
              SizedBox(height: 8),
              Text(temp.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
