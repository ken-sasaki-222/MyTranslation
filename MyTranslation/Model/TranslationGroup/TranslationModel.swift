//
//  TranslationModel.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/02.
//

import Foundation
import LanguageTranslator
import SwiftyJSON

// HomeVCに翻訳結果を返すプロトコル
protocol ReturnTranslationText {
    func returnTranslationText(text: String)
}

// 翻訳をおこなうクラス
class TranslationModel {
    
    // MARK: - プロパティ
    // HomeVCから渡ってきた値を保存する
    let translationKey : String
    let translationVer : String
    let translationURL : String
    let translationText: String
    
    // レスポンス結果をJSON型に変換
    var resultJSON: JSON?
    
    // 翻訳結果を保存する構造体のインスタンス
    var translation: [Translation] = []
    
    // 翻訳結果を返すプロトコルのインスタンス
    var returnTranslationText: ReturnTranslationText?
    
    // HomeVCから値を受け取る
    init(Key: String, version: String, url: String, text: String) {
        
        translationKey  = Key
        translationVer  = version
        translationURL  = url
        translationText = text
    }
    
    // MARK: - 翻訳開始
    // HomeVCから受け取った値を用いて翻訳をおこなう
    func startTranslation(language: String) {
        print("通信確認")
        
        // API認証情報
        let authenticator = WatsonIAMAuthenticator(apiKey: translationKey)
        let languageTranslator = LanguageTranslator(version: translationVer, authenticator: authenticator)
            languageTranslator.serviceURL = translationURL
        
        // リクエスト送信
        languageTranslator.translate(text: [translationText], modelID: language) {
            (response, error) in
            
            // エラー処理
            if let error = error {
                switch error {
                case let .http(statusCode, message, metadata):
                    switch statusCode {
                    case .some(404):
                        print("Not found (404)")
                    case .some(413):
                        print("Payload too large (413)")
                    default:
                        if let statusCode = statusCode {
                            print("Error - code: \(statusCode), \(message ?? "")")
                        }
                    }
                default:
                    print(error.localizedDescription)
                }
                return
            }
            
            // リクエスト結果が存在するのであれば呼ばれる（response?.result = リクエスト結果）
            if let result = response?.result {
                
                // レスポンス結果をJSON形式に整形
                let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                guard let translationResult = try? encoder.encode(result) else {
                    fatalError("Failed to encode to JSON.")
                }
                
                // SwiftyJSONのJSON型へ変換
                self.resultJSON = JSON(translationResult)
            }
            
            // JSON型に変換された翻訳結果を解析して必要な値の取り出し
            let japanLanguage = Translation(translation: self.resultJSON!["translations"][Count.zero]["translation"].string!)
            
            print("japanLanguage: \(japanLanguage.translation.debugDescription)")
            
            // HomeVCに値を返す
            self.returnTranslationText?.returnTranslationText(text: japanLanguage.translation)
        }
    }
}

