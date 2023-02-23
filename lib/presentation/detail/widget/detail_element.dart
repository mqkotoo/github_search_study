import 'package:flutter/material.dart';

class DetailElement extends StatelessWidget {
  const DetailElement({
    Key? key,
    required this.iconBackgroundColor,
    required this.icon,
    required this.iconColor,
    required this.elementLabel,
    required this.element,
  }) : super(key: key);

  final Color iconBackgroundColor;
  final IconData icon;
  final Color iconColor;
  final String elementLabel;
  final String element;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBackgroundColor,
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Text(elementLabel, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            element,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
