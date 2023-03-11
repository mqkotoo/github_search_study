import 'package:flutter/material.dart';

import 'package:github_search_study/presentation/search/widget/result_list_view.dart';
import 'package:github_search_study/presentation/search/widget/search_app_bar.dart';
import 'package:github_search_study/presentation/search/widget/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SearchAppBar(),
        body: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //search field
              child: SearchBar(),
            ),
            Divider(),
            //検索結果一覧のリスト
            ResultListview(),
          ],
        ),
      ),
    );
  }
}
