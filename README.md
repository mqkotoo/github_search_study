# 試験対策
## スクリーンショット
|結果一覧(light)|結果一覧(dark)|
|---|---|
|![Simulator Screen Shot - iPhone 14 - 2023-02-23 at 23 57 30](https://user-images.githubusercontent.com/87256037/220945800-d18d0b19-b841-4bb9-ba42-5edab835081b.png)|![Simulator Screen Shot - iPhone 14 - 2023-02-23 at 23 57 49](https://user-images.githubusercontent.com/87256037/220945978-2d198212-c3ea-4523-8d12-dc1432fc028a.png)|
|詳細(light)|詳細(dark)|
|![Simulator Screen Shot - iPhone 14 - 2023-02-23 at 23 58 03](https://user-images.githubusercontent.com/87256037/220946287-44346372-29ce-478c-9738-a2bafab130b2.png)|![Simulator Screen Shot - iPhone 14 - 2023-02-23 at 23 58 10](https://user-images.githubusercontent.com/87256037/220946361-e5299391-1736-4a60-8ecb-35d728722212.png)|
|結果なし|エラー|
|![Simulator Screen Shot - iPhone 14 - 2023-02-23 at 23 59 25](https://user-images.githubusercontent.com/87256037/220947730-83fbe2d7-5fbc-4b16-b48c-c5174352f355.png)|![Simulator Screen Shot - iPhone 14 - 2023-02-24 at 00 00 01](https://user-images.githubusercontent.com/87256037/220947806-4a107517-d6cc-4920-bd83-3a84df1bd6d6.png)|


デモ（縦）

https://user-images.githubusercontent.com/87256037/220951822-b5567b92-5f6e-4dbb-962b-c6368baaa646.mov

デモ（横）

https://user-images.githubusercontent.com/87256037/220952628-5ea7a678-2291-4649-9712-395e0a385c38.mov

### 動作
* ~何かしらのキーワードを入力できる~
* ~入力したキーワードで GitHub のリポジトリを検索できる~
* ~GitHub のリポジトリを検索する際、GitHub API（search/repositories）を利用する
  github | Dart Package のようなパッケージは利用せず、API を呼ぶ処理を自分で実装すること~
* ~検索結果は一覧で概要（リポジトリ名）を表示する~
* ~検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示する~

### UI/UX
* ~エラー発生時の処理~
* ~画面回転・様々な画面サイズ対応~
* ~Theme の適切な利用・ダークモードの対応~
* ~多言語対応~

## 環境

* IDE: Android Studio Electric Eel | 2022.1.1
* Flutter: 3.7.3
* Dart: 2.19.2
* サポートするプラットフォーム
　→iOS/Android

## 状態管理

flutter_riverpod: ^2.2.0

取得するデータを扱うプロバイダーは今回FutureProviderを使用しました。
FutureProviderを使うことで、扱う値が変わった時だけ読み込まれるため、不要なリクエストなどでパフォーマンスを損なう可能性が低くする意図で使った。

## 使用技術、パッケージ
* GitHub ActionsによるCI
* connectivity_plus -通信状況確認
* flutter_riverpod -状態管理
* freezed_annotation -freezedファイル生成
* http -apiの実装
* intl -言語、数字の成形
* json_annotation -jsonの変換
* shimmer -ロード画面の実装
* shared_preferences -テーマの保存
* flutter_localizations - 多言語対応
* device_preview -各サイズの画面でUIの確認

----dev----  
* flutter_test -テスト
* flutter_lints -静的解析
* build_runner -ファイルの生成
* freezed -immutableなクラス作成、json変換を簡単に
* json_serializable -jsonの変換
* mockito -データをモック化してテスト
* import_sorter -importの整列
* network_image_mock -データをモック化してテスト
* integration_test -統合テスト

## アーキテクチャ
・[CODE WITH ANDREA](https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/)を主に参考にしました

＊Application層は今回ない

・アーキテクチャについては理解が甘く、もっと勉強する必要があると思った

<img width="280" alt="スクリーンショット 2023-02-24 1 42 19" src="https://user-images.githubusercontent.com/87256037/220972746-34a0401f-962f-4717-8513-519f879ed3db.png">

### フォルダ構成
```
├── lib
│   ├── main.dart                    # アプリのエントリーポイント
│   ├── domain                       # ドメイン、データのモデル定義
│   ├── constant                     # 今回はアプリ内で使う色を定義
│   ├── repository                   # httpでの外部とのやりとり、メソッドの定義
│   ├── l10n                         # 多言語対応
│   ├── theme                        # テーマの提供、永続化
│   └── presentation                 # 見た目
│       ├── controller               # domainとpresentationの橋渡し
│       ├── detail                   # 詳細ページ（widgetも含む）
│       └── search                   # 検索ページ（widgetも含む）　　　　　　　　 
```

## ビルド手順
・クローン
```
git clone https://github.com/mqkotoo/github_search_study.git
```
・依存関係を読み込む（多言語対応も読み込まれます）
```
flutter pub get
```
・ビルドラン
```
flutter run
```

## テスト
### unitテスト
* データモデルの変換テスト
* データ取得メソッドのテスト
* テーマのテスト（初期状態、切り替え、テーマの記憶）
### widgetテスト
* 多言語対応のテスト
* 通信がない時のテスト
* 空文字でエラーが返るのテスト
* 検索ワードの入力、検索、画面遷移ができるかのテスト
### integrationテスト
* 検索ワードの入力、検索結果をタップすると画面遷移することを確認

### UIが崩れていないか
・ウィジェットテストだけでなく、[device_preview](https://pub.dev/packages/device_preview)を使っていろんな画面の大きさでも画面が崩れないことを確認しました。

## CI
* ```develop```もしくは```main```ブランチにプルリクエストが出された時に発火する
* インポートがeffective dart推奨のように整列されてあるか
* フォーマットが崩れていないか
  →基本的には保存時に自動フォーマットしています。
* 静的解析に引っかかっていないか
* テストを全て通過するか

## Note
* issueドリブンで開発をしました。
* プルリクエストベースで開発をして、安全に運用しました
* 可読性を意識して、widgetの切り分けをしました
* コメントで読みやすいようにしました
* シンプルで使いやすい、スタイリッシュなデザインを意識しました
* ユーザーが次のアクションがわかりやすいよう、ロードをshimmerにしました（スタイリッシュでもある）
* あえて、スプラッシュ画面を入れませんでした（iPhoneのメモアプリなど、簡単にすぐ使いたいものには入れない方が良いと思う）
* いろんな大きさの画面でも崩れないUIを意識しました
* スクロールバーをつけて、ユーザーが使いやすいようにした
* 多言語対応は他のアプリに倣ってアプリ内では操作できないようにした

## 感想、難しかったところ
* アーキテクチャの理解が甘いため、もっと勉強する必要がある
* エラーハンドリングが1番難しかった。いろいろなやり方があるのでさらに勉強してみる
* 投げたエラーをUIでどう表示させるかというのも難しかった。
* CIを初めてやってみたが、便利さが感じられて、品質を保証しやすいなと思った
* テストコードを初めてちゃんと書いたので、コードの書き方で不備や無駄、どこをどれくらいの粒度でテストするかなどは、まだ勉強していく必要がある、
* 今回は一機能作ったら、そのテストを書くというふうに決めてコードを書いたが、アプリがちゃんと動くことを保証でき、安心して開発を進めることができるし、コードを書き換えた時にそのコードがちゃんと動くのかというのをテストできる、というメリットを感じたのでこれからもテストは書いていきたいと思った。





