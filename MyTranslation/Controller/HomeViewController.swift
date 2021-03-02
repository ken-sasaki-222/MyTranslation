//
//  ViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/01.
//

import UIKit

// テキスト入力による翻訳をおこなうクラス
class HomeViewController: UIViewController, ReturnTranslationText {
    
    
    // MARK: - プロパティ
    // 翻訳前のテキストビュー
    @IBOutlet weak var beforTextView: UITextView!
    
    // 翻訳後のテキストビュー
    @IBOutlet weak var afterTextView: UITextView!
    
    // 翻訳を開始するボタン
    @IBOutlet weak var startTranslationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストビュー & ボタンの角丸
        beforTextView.layer.cornerRadius          = CGFloat(CornerRadius.eight)
        afterTextView.layer.cornerRadius          = CGFloat(CornerRadius.eight)
        startTranslationButton.layer.cornerRadius = CGFloat(CornerRadius.eight)
    }
    

    // MARK: - 翻訳開始ボタン
    // 翻訳開始をタップすると呼ばれる
    @IBAction func tapStartTranslationButton(_ sender: Any) {
        print("翻訳開始")
        
        // beforTextViewのテキストを読み取ってTranslationModelと通信をおこなう
        let translationModel = TranslationModel(Key: TRANSLATION_KEY, version: TRANSLATION_VER, url: TRANSLATION_URL, text: beforTextView.text)
        
        // 翻訳言語を渡してメソッドを呼ぶ
        translationModel.startTranslation(language: "en-ja")
        
        // デリゲートを委託
        translationModel.returnTranslationText = self
    }
    
    
    // MARK: - 翻訳終了
    // TranslationModelから値を受け取る
    func returnTranslationText(text: String) {
        
        // 翻訳結果のインスタンス作成
        let returnText = text
        
        // 翻訳結果をViewに反映
        DispatchQueue.main.async {
            self.afterTextView.text = returnText
        }
    }
  
    
    // MARK: - キーボードを閉じる
    // Viewタップでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

