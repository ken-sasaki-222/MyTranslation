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
    
    // 背景色
    static var backgroundColor = UIColor(hex: "f4f8fa")
    
    // アクセントカラー
    static var accentColor     = UIColor(hex: "1e90ff")
    
    // メインカラー（Textviewなど）
    static var mainColor       = UIColor.systemBackground
    
    // タブ非選択カラー（タブバー）
    static var notSelectColor  = UIColor.gray
}
