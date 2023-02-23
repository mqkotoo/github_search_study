import 'package:flutter/material.dart';

class VerRepoHeader extends StatelessWidget {
  const VerRepoHeader(
      {Key? key,
      required this.avatarUrl,
      required this.fullName,
      required this.description})
      : super(key: key);

  final String avatarUrl;
  final String fullName;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: widthSize * 0.05),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 120,
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              fullName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            description ?? "No Description",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
