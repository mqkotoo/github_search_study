import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:github_search_study/presentation/detail/widget/detail_element.dart';
import 'package:github_search_study/presentation/detail/widget/hori_repo_header.dart';
import 'package:github_search_study/presentation/detail/widget/ver_repo_header.dart';
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
            Text(S.of(context).detailPageTitle, key: const Key('detailAppBar')),
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

  Widget horiBody(BuildContext context, String starsCount, String watchersCount,
      String forksCount, String issuesCount) {
    final widthSize = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //ユーザー画像、リポ名、詳細
          HoriRepoHeader(
            avatarUrl: repoData.owner.avatarUrl,
            fullName: repoData.fullName,
            description: repoData.description,
          ),
          const Divider(),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widthSize * 0.1, vertical: 15),
            child: Column(
              children: <Widget>[
                //スター数などの詳細パーツ
                DetailElement(
                  icon: Icons.language,
                  elementLabel: S.of(context).language,
                  element: repoData.language ?? 'No Language',
                  iconBackgroundColor: Colors.blueAccent,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.star_outline,
                  elementLabel: S.of(context).star,
                  element: starsCount,
                  iconBackgroundColor: Colors.yellowAccent,
                  iconColor: Colors.black87,
                ),
                DetailElement(
                  icon: Icons.remove_red_eye_outlined,
                  elementLabel: S.of(context).watch,
                  element: watchersCount,
                  iconBackgroundColor: Colors.brown,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.fork_right_sharp,
                  elementLabel: S.of(context).fork,
                  element: forksCount,
                  iconBackgroundColor: Colors.purpleAccent,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.info_outline,
                  elementLabel: S.of(context).issue,
                  element: issuesCount,
                  iconBackgroundColor: Colors.green,
                  iconColor: Colors.white,
                ),
                const SizedBox(height: 30),
                //githubに飛ばす
                githubLinkText(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget verBody(BuildContext context, String starsCount, String watchersCount,
      String forksCount, String issuesCount) {
    final widthSize = MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.symmetric(
                vertical: 15, horizontal: widthSize * 0.05),
            child: Column(
              children: <Widget>[
                //スター数などの詳細パーツ
                DetailElement(
                  icon: Icons.language,
                  elementLabel: S.of(context).language,
                  element: repoData.language ?? 'No Language',
                  iconBackgroundColor: Colors.blueAccent,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.star_outline,
                  elementLabel: S.of(context).star,
                  element: starsCount,
                  iconBackgroundColor: Colors.yellowAccent,
                  iconColor: Colors.black87,
                ),
                DetailElement(
                  icon: Icons.remove_red_eye_outlined,
                  elementLabel: S.of(context).watch,
                  element: watchersCount,
                  iconBackgroundColor: Colors.brown,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.fork_right_sharp,
                  elementLabel: S.of(context).fork,
                  element: forksCount,
                  iconBackgroundColor: Colors.purpleAccent,
                  iconColor: Colors.white,
                ),
                DetailElement(
                  icon: Icons.info_outline,
                  elementLabel: S.of(context).issue,
                  element: issuesCount,
                  iconBackgroundColor: Colors.green,
                  iconColor: Colors.white,
                ),
                const SizedBox(height: 30),
                //githubに飛ばす
                githubLinkText(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //githubページに飛ばすテキスト
  Widget githubLinkText(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _openGitHubUrl(Uri.parse(repoData.htmlUrl)),
        child: Text(
          S.of(context).viewOnGitHub,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  //GitHubのリンク先に飛ばす
  Future<void> _openGitHubUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }
}
