//
//  MenuViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/05.
//

import UIKit

// メニューページを扱うクラス
class MenuViewController: UIViewController {
    
    
    // MARK: - プロパティ
    // メニューボックスのインスタンス
    @IBOutlet weak var reviewBox: UIView!
    @IBOutlet weak var mailBox: UIView!
    @IBOutlet weak var twitterBox: UIView!
    @IBOutlet weak var versionBox: UIView!
    
    // レビューラベルのインスタンス
    @IBOutlet weak var reviewLabel: UILabel!
    
    // お問い合わせラベルのインスタンス
    @IBOutlet weak var mailLabel: UILabel!
    
    // Twitter紹介ラベルのインスタンス
    @IBOutlet weak var twitterLabel: UILabel!
    
    // バージョン紹介ラベルのインスタンス
    @IBOutlet weak var versionLabel: UILabel!
    
    // ラベルに表示するテキストの配列
    var menuTextArray = ["レビュー", "お問い合わせ", "開発者", "Version 1.0"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light

        // ラベルにテキストを反映
        reviewLabel.text  = menuTextArray[Count.zero]
        mailLabel.text    = menuTextArray[Count.one]
        twitterLabel.text = menuTextArray[Count.two]
        versionLabel.text = menuTextArray[Count.three]
        
        // パーツの配色設定（ベースカラー）
        view.backgroundColor       = ColorList.baseColor
        reviewBox.backgroundColor  = ColorList.baseColor
        mailBox.backgroundColor    = ColorList.baseColor
        twitterBox.backgroundColor = ColorList.baseColor
        versionBox.backgroundColor = ColorList.baseColor
        
        // メニューの枠線の色
        reviewBox.layer.borderColor  = ColorList.itemColor.cgColor
        mailBox.layer.borderColor    = ColorList.itemColor.cgColor
        twitterBox.layer.borderColor = ColorList.itemColor.cgColor
        versionBox.layer.borderColor = ColorList.itemColor.cgColor
        
        // メニュー枠線の太さ
        reviewBox.layer.borderWidth  = CGFloat(Count.one)
        mailBox.layer.borderWidth    = CGFloat(Count.one)
        twitterBox.layer.borderWidth = CGFloat(Count.one)
        versionBox.layer.borderWidth = CGFloat(Count.one)
    }
    
    
    // MARK: - メニュータップアクション
    // レビューボックスをタップすると呼ばれる
    @IBAction func tapReviewButton(_ sender: Any) {
        print("レビューをタップ")
    }
    
    // お問い合わせボックスをタップすると呼ばれる
    @IBAction func tapMailButton(_ sender: Any) {
        print("お問い合わせをタップ")
    }
    
    // Twitter紹介ボックスをタップすると呼ばれる
    @IBAction func tapTwitterButton(_ sender: Any) {
        print("Twitterをタップ")
    }
}
