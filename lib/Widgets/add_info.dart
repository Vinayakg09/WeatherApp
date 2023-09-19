import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String mid;
  final String value;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.mid,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(
          height: 8,
        ),
        Text(mid),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
