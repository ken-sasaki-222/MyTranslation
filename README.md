## アプリの概要
無駄な機能が一切無いシンプルな翻訳アプリ
[AppleStoreからインストール](#)

## 開発の経緯
App Storeからダウンロードできる翻訳アプリを多数使った結果、開発者が使いやすいと思えるアプリには出会えなかった。      
webアプリケーションではDeepLが最も使いやすく現在も愛用している。  
そこで、『使いづらいのなら自作しよう！』と考えたのが開発経緯です。  

使いやすいの定義は以下の3点  
・無駄がない  
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
### Swift version 5.3.2
・MVCモデル開発
・JSON解析    
・AutoLayout（Storyboard）  
・Autoresizing

### Firebase
・Firebase ML Kit   
 
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

## 開発者の連絡先
俺の翻訳に関するご連絡はアカウントをフォローしていただき[Twitter](https://twitter.com/ken_sasaki2)のダイレクトメッセージにて連絡。  
もしくは、アプリ内の**ご意見・ご要望**からご連絡下さい。  
プルリクエストも大歓迎です。

▼その他連絡先  
[Qiita](https://qiita.com/nkekisasa222)  
[Github](https://github.com/ken-sasaki-222)
