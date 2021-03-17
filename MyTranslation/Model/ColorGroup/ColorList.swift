//
//  ColorList.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/03.
//

import Foundation
import UIKit

// 配色を扱うクラス
class ColorList {
    
    // ベースカラー（主に背景色）
    static var baseColor      = UIColor(hex: "f8f4e6")
    
    // メインカラー（Textviewなど）
    static var mainColor      = UIColor.systemBackground
    
    // アクセントカラー1（翻訳ボタンなど）
    static var accentGreen    = UIColor.systemGreen
    
    // アクセントカラー2（読み上げボタンなど）
    static var accentIndigo   = UIColor.systemIndigo
    
    // アイテムカラー（文字など）
    static var itemColor      = UIColor.label
    
    // タブ非選択カラー（タブバー）
    static var notSelectColor = UIColor.gray
}
