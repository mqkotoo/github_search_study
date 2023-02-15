import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFDF6),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCFDF6),
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text("Repo Detail"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ClipOval(
              child: Image.network(
                "https://avatars.githubusercontent.com/u/14101776?v=4",
                width: 120,
                height: 120,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "flutter/flutter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
            child: Text(
              "これはFlutterのリポジトリです。FlutterはGOOGLEさんが開発したいい感じのフレームワークです。",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
          const Divider(),

          //リポジトリのスター数など
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                verDetailElement(
                  icon: Icons.language,
                  elementLabel: "Language",
                  element: "dart",
                  iconBackgroundColor: Colors.blueAccent,
                  iconColor: Colors.white,
                ),
                verDetailElement(
                  icon: Icons.star_border,
                  elementLabel: "Star",
                  element: 100.toString(),
                  iconBackgroundColor: Colors.yellowAccent,
                  iconColor: Colors.black87,
                ),
                verDetailElement(
                  icon: Icons.remove_red_eye_outlined,
                  elementLabel: "Watch",
                  element: 200.toString(),
                  iconBackgroundColor: Colors.brown,
                  iconColor: Colors.white,
                ),
                verDetailElement(
                  icon: Icons.fork_right_sharp,
                  elementLabel: "Fork",
                  element: 300.toString(),
                  iconBackgroundColor: Colors.purpleAccent,
                  iconColor: Colors.white,
                ),
                verDetailElement(
                  icon: Icons.info_outline,
                  elementLabel: "Issue",
                  element: 400.toString(),
                  iconBackgroundColor: Colors.greenAccent,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget verDetailElement(
      {iconBackgroundColor, icon, iconColor, elementLabel, element}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
