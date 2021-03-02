//
//  Translation.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/02.
//

import Foundation

// 翻訳結果を保存する場合に扱う
struct Translation {
    
    // 翻訳結果を保存する値
    let translation: String
    
    // translationに翻訳結果を代入しself.translationに値を保存
    init(translation: String) {
        self.translation = translation
    }
}
