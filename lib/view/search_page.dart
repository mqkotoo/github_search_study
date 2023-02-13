import 'package:flutter/material.dart';

import 'detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("GitHub Repo Search"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Colors.grey),
                fillColor: const Color(0xffe1eedf),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              //入力キーボードのdone→searchに変更
              textInputAction: TextInputAction.search,
              //search押したらデータ取得
              onFieldSubmitted: (text) => print(text),
            ),
          ),
          Divider(color: Colors.black12),
          // total count
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text("result: 12345"),
            ),
          ),

          Expanded(
            child: ListView.separated(
                itemCount: 15,
                itemBuilder: (context, index) => _listItem(context),
                separatorBuilder: (context, index) => const Divider(
                      color: Color(0xffBBBBBB),
                    )),
          )
        ],
      ),
    );
  }

  Widget _listItem(context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage()),
        );
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text("flutter/flutter",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              "description--------------------------------------------あいうろあいうえお",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
