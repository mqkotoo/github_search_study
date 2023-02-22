import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField(
      {Key? key,
      required this.onFieldSubmitted,
      required this.isClearVisible,
      required this.onPressClearButton,
      required this.onChanged,
      required this.textController})
      : super(key: key);

  final void Function(String) onFieldSubmitted;
  final bool isClearVisible;
  final void Function() onPressClearButton;
  final void Function(String) onChanged;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //横画面の場合ノッチに隠れないようにする
    //safeareaにすると間延びして変な見た目になる
    if (size.height < size.width) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          key: const Key("inputForm"),
          controller: textController,
          onChanged: onChanged,

          //decoration
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: isClearVisible
                ? IconButton(
                    key: const Key("clearButton"),
                    icon: const Icon(Icons.clear),
                    onPressed: onPressClearButton,
                    color: Colors.grey)
                : const SizedBox.shrink(),
          ),

          //入力キーボードのdone→searchに変更
          textInputAction: TextInputAction.search,
          //search押したらデータ取得
          onFieldSubmitted: onFieldSubmitted,
        ),
      );
    }

    return TextFormField(
      key: const Key("inputForm"),
      controller: textController,
      onChanged: onChanged,

      //decoration
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: isClearVisible
            ? IconButton(
                key: const Key("clearButton"),
                icon: const Icon(Icons.clear),
                onPressed: onPressClearButton,
                color: Colors.grey)
            : const SizedBox.shrink(),
      ),

      //入力キーボードのdone→searchに変更
      textInputAction: TextInputAction.search,
      //search押したらデータ取得
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
