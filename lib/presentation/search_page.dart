import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'controller/controllers.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoData = ref.watch(apiFamilyProvider(ref.watch(inputRepoNameProvider)));
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
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
              //search押したらデータ取得 データ渡す
              // onFieldSubmitted: (text) => dataRepository.getData(text),
              onFieldSubmitted: (text) => ref.read(inputRepoNameProvider.notifier).update((state) => text),
            ),
          ),
          const Divider(color: Colors.black12),
          // total count
          (() {
            //初期状態
            if(ref.watch(inputRepoNameProvider) == "" ){
              //この場合は「リポジトリ名を入力してください」みたいな
              return Text('初期状態');
            }
            if (repoData.value != null && repoData.value!.totalCount != 0) {
              //resultをカンマ区切りで表示
              String totalCount =
              NumberFormat('#,##0').format(repoData.value!.totalCount);
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text("result: $totalCount"),
                ),
              );
            }
            if (repoData.value != null && repoData.value!.totalCount == 0) {
              //この場合は「見つかりませんでした」みたいな
              return const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  //横画面にした時にノッチで隠れないようにsafeareaで囲む
                  child: Text("result: 0"),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          })(),

          Expanded(
            flex: 8,
            child: repoData.when(
              data: (data) => ListView.separated(
                  itemCount: data.items.length,
                  itemBuilder: (context, index) => _listItem(
                    fullName: data.items[index].fullName,
                    description: data.items[index].description,
                    onTap: () {
                    },
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xffBBBBBB),
                  )),
              error: (error, stack) => Text(error.toString()),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _listItem({fullName,description,onTap}) {
    return ListTile(
      onTap: () async {
        //画面遷移する処理と、プロバイダーにそのインデックスの情報を渡す処理をする
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DetailPage()),
        // );
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(fullName,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
