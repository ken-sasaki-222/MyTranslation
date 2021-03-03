//
//  ViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/01.
//

import UIKit
import EMAlertController


// テキスト入力による翻訳をおこなうクラス
class HomeViewController: UIViewController, ReturnTranslationText, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    // MARK: - プロパティ
    // テキストビュー（原文）
    @IBOutlet weak var beforTextView: UITextView!
    
    // テキストビュー（訳文）
    @IBOutlet weak var afterTextView: UITextView!
    
    // 翻訳を開始するボタン
    @IBOutlet weak var startTranslationButton: UIButton!
    
    // 言語を入力する（原文）
    @IBOutlet weak var beforLanguageText: UITextField!
    
    // 言語を入力する（訳文）
    @IBOutlet weak var afterLanguageText: UITextField!
    
    // 言語を選択するピッカー（原文）
    var beforLanguagePicker = UIPickerView()
    
    // 言語を選択するピッカー（訳文）
    var afterLanguagePicker = UIPickerView()
    
    // ピッカーに表示する言語配列
    let languageArray = ["日本語", "英語", "韓国語", "中国語"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストビュー & ボタンの角丸
        beforTextView.layer.cornerRadius          = CGFloat(CornerRadius.eight)
        afterTextView.layer.cornerRadius          = CGFloat(CornerRadius.eight)
        startTranslationButton.layer.cornerRadius = CGFloat(CornerRadius.eight)
        
        // 言語選択Pickerを呼び出す（原文）
        createBeforLanguagePickerView()
        
        // 言語選択Pickerを呼び出す（訳文）
        createAfterLanguagePickerView()
    }
    
    
    // MARK: - 言語選択処理
    // Pickerを作成する（原文）
    func createBeforLanguagePickerView() {
        
        // デリゲートの委託とtagを設定
        beforLanguagePicker.delegate   = self
        beforLanguagePicker.dataSource = self
        beforLanguagePicker.tag        = Count.one
        
        // 入力のキーボードをPickerViewに
        beforLanguageText.inputView = beforLanguagePicker
        
        // ツールバーも作成
        let toolbar = UIToolbar()
            toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        
        // ツールバーのボタンを作成
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        
        // ツールバーにボタンを反映
        toolbar.setItems([doneButtonItem], animated: true)
        
        // ツールバーを反映
        beforLanguageText.inputAccessoryView = toolbar
    }
    
    // Pickerを作成する（訳文）
    func createAfterLanguagePickerView() {
        
        // デリゲートの委託とtagに設定
        afterLanguagePicker.delegate   = self
        afterLanguagePicker.dataSource = self
        afterLanguagePicker.tag        = Count.two
        
        // 入力のキーボードをPickerViewに
        afterLanguageText.inputView = afterLanguagePicker
        
        // ツールバーも作成
        let toolbar = UIToolbar()
            toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        
        // ツールバーのボタンを作成
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        
        // ツールバーにボタンを反映
        toolbar.setItems([doneButtonItem], animated: true)
        
        // ツールバーを反映
        afterLanguageText.inputAccessoryView = toolbar
    }
    
    // ツールバーのdoneボタンをタップした場合に呼ばれる
    @objc func donePicker() {
        
        // Pickerを閉じる
        beforLanguageText.endEditing(true)
        afterLanguageText.endEditing(true)
    }
    
    // Pickerの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Count.one
    }
    
    // Pickerの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == Count.one {
            return languageArray.count
        } else {
            return languageArray.count
        }
    }
    
    // Pickerに表示する文字列を設定
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == Count.one {
            return languageArray[row]
        } else {
            return languageArray[row]
        }
    }
    
    // Pickerを選択した場合の挙動を確認
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == Count.one {
            beforLanguageText.text = languageArray[row]
        } else {
            afterLanguageText.text = languageArray[row]
        }
    }


    // MARK: - 翻訳開始ボタン
    // 翻訳開始をタップすると呼ばれる
    @IBAction func tapStartTranslationButton(_ sender: Any) {
        
        // 原文がnilの場合はアラートを表示
        if beforTextView.text == "" {
            
            // アラートのインスタンス
            let alert = EMAlertController(icon   : UIImage(named: "キャンセル"),
                                          title  : "翻訳できません",
                                          message: "原文を入力して下さい")
            
            // アラートのアクションを設定しアラートを追加
            let doneAction = EMAlertAction(title: "やり直す", style: .normal)
            alert.addAction(doneAction)
            
            // アラートの表示
            present(alert, animated: true, completion: nil)
        } else {
            
            // beforTextViewのテキストを読み取ってTranslationModelと通信をおこなう
            let translationModel = TranslationModel(Key: TRANSLATION_KEY, version: TRANSLATION_VER, url: TRANSLATION_URL, text: beforTextView.text)
            
            // 翻訳種類を複数作成して、選択されたものと同じ値をstartTranslationに渡す
            
            // 原文を渡してメソッドを呼ぶ
            translationModel.startTranslation(language: "en-ja")
            
            // デリゲートを委託
            translationModel.returnTranslationText = self
        }
    }
    
    
    // MARK: - 翻訳終了処理
    // TranslationModelから値を受け取る
    func returnTranslationText(text: String) {
        
        // 翻訳結果のインスタンス作成
        let returnText = text
        
        // 翻訳結果をViewに反映
        DispatchQueue.main.async {
            self.afterTextView.text = returnText
        }
    }
    
    
    // MARK: - クリアアクション
    // クリアボタンをタップすると呼ばれる
    @IBAction func tapclearButton(_ sender: Any) {
        
        beforTextView.text = nil
        afterTextView.text = nil
    }
    
    
    // MARK: - 入力アクションを閉じる
    // Viewタップ閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // キーボードーを閉じる
        self.view.endEditing(true)
        
        // Pickerを閉じる
        self.beforLanguageText.endEditing(true)
        self.afterLanguageText.endEditing(true)
    }
}

