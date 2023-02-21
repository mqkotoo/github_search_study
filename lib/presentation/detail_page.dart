import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../domain/repository_data_model.dart';
import '../generated/l10n.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.repoData, Key? key}) : super(key: key);

  final RepositoryDataItems repoData;

  @override
  Widget build(BuildContext context) {
    // データの数をカンマ区切りで表示
    final starsCount = NumberFormat('#,##0').format(repoData.stargazersCount);
    final watchersCount = NumberFormat('#,##0').format(repoData.watchersCount);
    final forksCount = NumberFormat('#,##0').format(repoData.forksCount);
    final issuesCount = NumberFormat('#,##0').format(repoData.openIssuesCount);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            S.of(context).detailPageTitle,
            key: const Key("detailAppBar")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      repoData.owner.avatarUrl,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      repoData.fullName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Text(repoData.description ?? "No Description"),
                ],
              ),
            ),
            const Divider(),
            //リポジトリのスター数など
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  verDetailElement(
                    icon: Icons.language,
                    elementLabel: S.of(context).language,
                    element: repoData.language ?? "No Language",
                    iconBackgroundColor: Colors.blueAccent,
                    iconColor: Colors.white,
                  ),
                  verDetailElement(
                    icon: Icons.star_outline,
                    elementLabel:S.of(context).star,
                    element: starsCount,
                    iconBackgroundColor: Colors.yellowAccent,
                    iconColor: Colors.black87,
                  ),
                  verDetailElement(
                    icon: Icons.remove_red_eye_outlined,
                    elementLabel: S.of(context).watch,
                    element: watchersCount,
                    iconBackgroundColor: Colors.brown,
                    iconColor: Colors.white,
                  ),
                  verDetailElement(
                    icon: Icons.fork_right_sharp,
                    elementLabel: S.of(context).fork,
                    element: forksCount,
                    iconBackgroundColor: Colors.purpleAccent,
                    iconColor: Colors.white,
                  ),
                  verDetailElement(
                    icon: Icons.info_outline,
                    elementLabel: S.of(context).issue,
                    element: issuesCount,
                    iconBackgroundColor: Colors.greenAccent,
                    iconColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget verDetailElement(
      {iconBackgroundColor, icon, iconColor, elementLabel, element}) {
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
