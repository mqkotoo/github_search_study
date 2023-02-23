import 'package:flutter/material.dart';
import 'package:github_search_study/presentation/detail/widget/ver_detail_element.dart';
import 'package:github_search_study/presentation/detail/widget/ver_repo_header.dart';

import 'package:intl/intl.dart';

import '../../domain/repository_data_model.dart';
import '../../generated/l10n.dart';

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
        title:
            Text(S.of(context).detailPageTitle, key: const Key("detailAppBar")),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < constraints.maxHeight
              ? verBody(
                  context, starsCount, watchersCount, forksCount, issuesCount)
              : horiBody(
                  context, starsCount, watchersCount, forksCount, issuesCount);
        },
      ),
    );
  }

  Widget horiRepoHeader(context) {
    final widthSize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Image.network(
              repoData.owner.avatarUrl,
              width: 90,
              height: 90,
            ),
          ),
          SizedBox(
            width: widthSize * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  repoData.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  repoData.description ?? "No Description",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget horiDetailElement(
      {iconBackgroundColor, icon, iconColor, elementLabel, element, context}) {
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

  Widget horiBody(context, starsCount, watchersCount, forksCount, issuesCount) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horiRepoHeader(context),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horiDetailElement(
                      icon: Icons.language,
                      elementLabel: S.of(context).language,
                      element: repoData.language ?? "No Language",
                      iconBackgroundColor: Colors.blueAccent,
                      iconColor: Colors.white,
                    ),
                    horiDetailElement(
                      icon: Icons.star_outline,
                      elementLabel: S.of(context).star,
                      element: starsCount,
                      iconBackgroundColor: Colors.yellowAccent,
                      iconColor: Colors.black87,
                    ),
                    horiDetailElement(
                      icon: Icons.remove_red_eye_outlined,
                      elementLabel: S.of(context).watch,
                      element: watchersCount,
                      iconBackgroundColor: Colors.brown,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horiDetailElement(
                      icon: Icons.fork_right_sharp,
                      elementLabel: S.of(context).fork,
                      element: forksCount,
                      iconBackgroundColor: Colors.purpleAccent,
                      iconColor: Colors.white,
                    ),
                    horiDetailElement(
                      icon: Icons.info_outline,
                      elementLabel: S.of(context).issue,
                      element: issuesCount,
                      iconBackgroundColor: Colors.greenAccent,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget verBody(context, starsCount, watchersCount, forksCount, issuesCount) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //ユーザー画像、リポ名、詳細
          VerRepoHeader(
              avatarUrl: repoData.owner.avatarUrl, 
              fullName: repoData.fullName, 
              description: repoData.description,
          ),
          const Divider(),
          //リポジトリのスター数など
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //スター数などの詳細パーツ
                VerDetailElement(
                  icon: Icons.language,
                  elementLabel: S.of(context).language,
                  element: repoData.language ?? "No Language",
                  iconBackgroundColor: Colors.blueAccent,
                  iconColor: Colors.white,
                ),
                VerDetailElement(
                  icon: Icons.star_outline,
                  elementLabel: S.of(context).star,
                  element: starsCount,
                  iconBackgroundColor: Colors.yellowAccent,
                  iconColor: Colors.black87,
                ),
                VerDetailElement(
                  icon: Icons.remove_red_eye_outlined,
                  elementLabel: S.of(context).watch,
                  element: watchersCount,
                  iconBackgroundColor: Colors.brown,
                  iconColor: Colors.white,
                ),
                VerDetailElement(
                  icon: Icons.fork_right_sharp,
                  elementLabel: S.of(context).fork,
                  element: forksCount,
                  iconBackgroundColor: Colors.purpleAccent,
                  iconColor: Colors.white,
                ),
                VerDetailElement(
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
    );
  }
}
