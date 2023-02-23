import 'package:flutter/material.dart';

class HoriDetailElement extends StatelessWidget {
  const HoriDetailElement(
      {Key? key,
        required this.iconBackgroundColor,
        required this.icon,
        required this.iconColor,
        required this.elementLabel,
        required this.element,
      })
      : super(key: key);

  final Color iconBackgroundColor;
  final IconData icon;
  final Color iconColor;
  final String elementLabel;
  final String element;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBackgroundColor,
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Text(elementLabel, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 20),
          Text(element, style: const TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
