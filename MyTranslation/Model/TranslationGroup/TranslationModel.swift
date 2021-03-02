//
//  TranslationModel.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/02.
//

import Foundation
import LanguageTranslator

// 翻訳をおこなうクラス
class TranslationModel {
    
    // MARK: - プロパティ
    // HomeVCから渡ってきた値を保存する
    let translationKey : String
    let translationVer : String
    let translationURL : String
    let translationText: String
    
    // HomeVCから値を受け取る
    init(Key: String, version: String, url: String, beforeTranslationText: String) {
        
        translationKey  = Key
        translationVer  = version
        translationURL  = url
        translationText = beforeTranslationText
    }
    
    // MARK: - 翻訳開始
    // HomeVCから受け取った値を用いて翻訳をおこなう
    func startTranslation() {
        print("通信確認")
    }
}
