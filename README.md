## アプリの概要
無駄な機能が一切無いシンプルな翻訳アプリ  
[AppleStoreからインストール](https://apps.apple.com/jp/app/%E4%BF%BA%E3%81%AE%E7%BF%BB%E8%A8%B3/id1558810713)

## 開発の経緯
App Storeからダウンロードできる翻訳アプリを多数使った結果、開発者が使いやすいと思えるアプリには出会えなかった。      webアプリケーションではDeepLが最も使いやすく現在も愛用している。  
そこで、『使いづらいのなら自作しよう！』と考えたのが開発経緯です。  

■『使いやすい』の定義は以下の2点  
・UIがシンプル  
・翻訳言語が限定されている

## 機能一覧
・翻訳機能（英語、日本語のみ）  
・翻訳内容読み上げ機能  
・翻訳履歴表示機能  
・お問い合わせ機能  
・レビュー機能  
・Twitter紹介機能（開発者）  

## 開発で使用した技術
![HappyNews＿README用アイコン](https://user-images.githubusercontent.com/61372276/111485153-b60c8b00-8779-11eb-801a-47f4c9a81d58.jpeg)
### Swift version 5.3.2
・MVCモデル開発  
・JSON解析    
・AutoLayout（Storyboard）  
・Autoresizing

### Watson API
・LanguageTranslator（言語翻訳）

### Firebase
・Firebase ML Kit   

### テスト
・Magic Pod（AI自動テスト）  
[詳細はコチラから](https://www.magic-pod.com/) 
 
以下、使用したCocoaPodsとライブラリ
```
pod 'IBMWatsonLanguageTranslatorV3', '~> 3.6.0'
pod 'SwiftyJSON'

pod 'EMAlertController'

pod 'Firebase/MLNaturalLanguage', '6.25.0'
pod 'Firebase/MLNLLanguageID', '6.25.0'
```

```
# 翻訳機能で使用
import LanguageTranslator
import SwiftyJSON
import EMAlertController

# 翻訳内容読み上げ機能で使用
import Firebase
import AVFoundation

# アカウントページで使用
import StoreKit
import MessageUI

# その他
import UIKit
import Foundation
```

## 工夫したポイント
#### MagicPodを使ってUIテストを実施
XCTestは使わずMagic Podを用いてUIテスト行いました。

理由は以下の3点が挙げられます。

①XCTestはタイムコストがかかってしまうという点  
②Magic Podは環境構築コスト、学習コストの両方が低コストであるという点  
③note株式会社や、株式会社Gunosyでも使用実例が公開されておりモダンであると判断したため

結果、UIテストを短時間で行えた点と、モダンな技術に触れることができたので良かったです。

## 今後の課題
実際にユーザーに使っていただくことで見えてくる課題が存在すると考えています。  
なのでApp Storeへの公開を最優先に考えています。

なので現状の最小機能でひとまず公開します。  
その後追加実装を予定しているのは以下の2点です。

①音声入力機能  
②画像テキスト読み取り機能

これらの機能を今後の課題とします。

## 機能紹介
### 翻訳機能の紹介
![ホーム画面動画](https://user-images.githubusercontent.com/61372276/111493476-edcb0100-8780-11eb-8735-69cdd6ff3182.gif)

### 翻訳内容読み上げ機能(ホーム)の紹介
![読み上げ動画1](https://user-images.githubusercontent.com/61372276/111493781-3a164100-8781-11eb-90a5-770f13eb345e.gif)

※正常に読み上げています

### 翻訳内容読み上げ機能(履歴)の紹介
![読み上げ動画2](https://user-images.githubusercontent.com/61372276/111493924-5d40f080-8781-11eb-9af4-3c360094367c.gif)

※正常に読み上げています

### レビュー機能の紹介
![レビュー](https://user-images.githubusercontent.com/61372276/111494049-7ba6ec00-8781-11eb-801d-f50bfa50db43.gif)

### お問い合わせ機能の紹介


### Twitter紹介機能の紹介
![twitter紹介](https://user-images.githubusercontent.com/61372276/111494140-92e5d980-8781-11eb-8bd1-85f56343c3cc.gif)


## 開発者の連絡先
このアプリに関するご連絡はアカウントをフォローしていただき[Twitter](https://twitter.com/ken_sasaki2)のダイレクトメッセージにて連絡。  
もしくは、アプリ内のお問い合わせからご連絡下さい。  
プルリクエストも大歓迎です。

▼その他連絡先  
[Qiita](https://qiita.com/nkekisasa222)  
[Github](https://github.com/ken-sasaki-222)
