//
//  ReturnLanguageCodeModel.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/08.
//

import Foundation
import Firebase

// Controllerへ値を返すプロトコル
protocol DoneCatchReturnLanguageCode {
    func doneCatchReturnLanguageCode(cellNum: Int ,languageCode: String)
}

// 翻訳内容の言語判別をおこなうクラス
class ReturnLanguageCodeModel {
    
    
    // MARK: - プロパティ
    // 言語判別で扱うインスタンス
    let languageId = NaturalLanguage.naturalLanguage().languageIdentification()
    
    // プロトコルのインスタンス
    var doneCatchReturnLanguageCode: DoneCatchReturnLanguageCode?
    
    // Controllerから値を受け取る
    var indexNum: Int
    var languageText: String
    
    // Controllerから渡ってくる値を保存する
    init(id: Int, text: String) {
        
        indexNum     = id
        languageText = text
    }
    
    
    // MARK: - 言語判別機能
    // 言語判別をおこなう
    func startIdentifyLanguage() {
        
        // 言語判別を行う
        languageId.identifyLanguage(for: languageText) {
            (languageCode, error) in
            
            // エラー処理
            if let error = error {
                print("Failed with error: \(error)")
                return
            }
            
            // 言語判別結果の値が存在し、undでない場合呼ばれる
            if let languageCode = languageCode, languageCode != "und" {
                
                print("言語コード: \(languageCode)")
                
                // Controllerへ値を返す
                self.doneCatchReturnLanguageCode?.doneCatchReturnLanguageCode(cellNum: self.indexNum, languageCode: languageCode)
            } else {
                print("No language was identified")
            }
        }
    }
}
