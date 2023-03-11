# 試験対策
## スクリーンショット
|結果一覧(light)|結果一覧(dark)|
|---|---|
|![Simulator Screen Shot - iPhone 14 - 2023-03-09 at 21 48 35](https://user-images.githubusercontent.com/87256037/224027665-3aa0748b-ef2c-461a-9a27-848a7aa989d6.png)|![simulator_screenshot_771FE4D0-83FB-4B26-A420-24F16A254BE7](https://user-images.githubusercontent.com/87256037/224027872-80e1e211-5a88-4393-8fe5-a10c7d26e064.png)|

|詳細(light)|詳細(dark)|
|---|---|
|![Simulator Screen Shot - iPhone 14 - 2023-03-10 at 14 06 10](https://user-images.githubusercontent.com/87256037/224228477-434e0166-713e-448f-a7e5-232a08fe10b9.png)|![Simulator Screen Shot - iPhone 14 - 2023-03-10 at 14 06 15](https://user-images.githubusercontent.com/87256037/224228528-1358044a-7f92-48ea-a99f-bf32fd6387c1.png)


|結果なし|エラー|
|---|---|
|![simulator_screenshot_FD8471DD-D371-4F9A-97B8-6E259816B8C8](https://user-images.githubusercontent.com/87256037/224028254-d2c0eb34-9f5f-437b-9263-47490ed633bf.png)|![simulator_screenshot_F6E9F8A1-0D63-4F4D-BAD0-6F2BC2902C2E](https://user-images.githubusercontent.com/87256037/224029474-89b43eeb-81d0-434e-9493-d07ee8e93a47.png)|


デモ（縦）

https://user-images.githubusercontent.com/87256037/224030225-2e6785f4-cd8d-4a8a-97f8-bd3c4ef8b6ad.mov

デモ（横）

https://user-images.githubusercontent.com/87256037/224031288-a049e658-0e24-4508-8d39-c261bc8af18e.mov




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
* ~多言語対応 (英語、日本語)~

## 環境

* IDE: Android Studio Electric Eel | 2022.1.1
* Flutter: 3.7.3
* Dart: 2.19.2
* サポートするプラットフォーム
　→iOS/Android

## 状態管理

flutter_riverpod: ^2.2.0

取得するデータを扱うプロバイダーは今回FutureProviderを使用しました。
FutureProviderを使うことで、取得したデータのキャッシュ、loadingなどの操作が簡単、値が変化する時だけ再描画されるなどのメリットがあると考えました。

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

### UIが崩れていないか（目で見て確認したところ）
* ウィジェットテストだけでなく、[device_preview](https://pub.dev/packages/device_preview)を使っていろんな画面の大きさでも画面が崩れないか
* 各画面で視認性が落ちていないか
* OSの仕様で崩れていないか
* 横画面になっても崩れないか
* 特に横画面でSafeAreaを干渉していないか
* ユーザーの端末の設定でテキストが大きくなっても画面が崩れないか
* 多言語対応に関して、タイポがないか
* 表現がおかしくないか
* 他の言語にしても画面が崩れないか

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
* スクロールバーをつけて、ユーザーが使いやすいようにしました
* 多言語対応は他のアプリに倣ってアプリ内では操作できないようにした
* 検索結果の並び替え機能をつけました
* GitHub上で見れるようにリンクを設けました

## 感想、難しかったところ
* アーキテクチャの理解が甘いため、もっと勉強する必要がある
* エラーハンドリングが1番難しかった。いろいろなやり方があるのでさらに勉強してみる
* 投げたエラーをUIでどう表示させるかというのも難しかった。
* CIを初めてやってみたが、便利さが感じられて、品質を保証しやすいなと思った
* テストコードを初めてちゃんと書いたので、コードの書き方で不備や無駄、どこをどれくらいの粒度でテストするかなどは、まだ勉強していく必要がある、
* 今回は一機能作ったら、そのテストを書くというふうに決めてコードを書いたが、アプリがちゃんと動くことを保証でき、安心して開発を進めることができるし、コードを書き換えた時にそのコードがちゃんと動くのかというのをテストできる、というメリットを感じたのでこれからもテストは書いていきたいと思った。





