//
//  ViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/01.
//

import UIKit
import EMAlertController
import AVFoundation


// テキスト入力による翻訳をおこなうクラス
class HomeViewController: UIViewController, ReturnTranslationText, UIPickerViewDelegate, UIPickerViewDataSource, DoneCatchReturnLanguageCode {
    
    
    // MARK: - プロパティ
    // テキストビュー（原文）
    @IBOutlet weak var beforTextView: UITextView!
    
    // テキストビュー（訳文）
    @IBOutlet weak var afterTextView: UITextView!
    
    // 翻訳を開始するボタン
    @IBOutlet weak var startTranslationButton: UIButton!
    
    // テキスト読み上げを開始するボタン
    @IBOutlet weak var speeshButton: UIButton!
    
    // 言語を入力する（原文）
    @IBOutlet weak var beforLanguageText: UITextField!
    
    // 言語を入力する（訳文）
    @IBOutlet weak var afterLanguageText: UITextField!
    
    // 言語を選択するピッカー（原文）
    var beforLanguagePicker = UIPickerView()
    
    // 言語を選択するピッカー（訳文）
    var afterLanguagePicker = UIPickerView()
    
    // 原文-訳文をクリアするボタン
    @IBOutlet weak var freshButton: UIButton!
    
    // ピッカーに表示する言語配列
    let languageArray = ["言語を選択", "🇯🇵", "🇺🇸"]
    
    // 原文-訳文を保存してModelへ渡す
    var language: String?
    
    // 翻訳履歴を保存する配列
    var returnTextArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        
        // テキストビュー & ボタンの角丸
        beforTextView.layer.cornerRadius          = CGFloat(CornerRadius.size)
        afterTextView.layer.cornerRadius          = CGFloat(CornerRadius.size)
        startTranslationButton.layer.cornerRadius = CGFloat(CornerRadius.size)
        speeshButton.layer.cornerRadius           = CGFloat(CornerRadius.size)
        
        // パーツの配色設定（ベースカラー）
        view.backgroundColor              = ColorList.baseColor
        beforLanguageText.backgroundColor = ColorList.baseColor
        afterLanguageText.backgroundColor = ColorList.baseColor
        
        // パーツの配色設定（メインカラー）
        beforTextView.backgroundColor = ColorList.mainColor
        afterTextView.backgroundColor = ColorList.mainColor
        
        // パーツの配色設定（アイテムカラー）
        freshButton.tintColor = ColorList.itemColor
        
        // パーツの配色設定（アクセントカラー）
        startTranslationButton.backgroundColor = ColorList.accentGreen
        speeshButton.backgroundColor           = ColorList.accentIndigo
        
        // キーボードに閉じるボタンを追加
        let toolbar = UIToolbar()
            toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        
        // ツールバーのボタンを作成
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneKeyboard))
        
        // ツールバーにボタンを反映
        toolbar.setItems([doneButtonItem], animated: true)
        
        // ツールバーを反映
        beforTextView.inputAccessoryView = toolbar
        afterTextView.inputAccessoryView = toolbar
        
        // ローカルに保存されている翻訳履歴が空であれば呼ばれる
        if  UserDefaults.standard.array(forKey: "returnTextArray") == nil {
            
            // エラー回避の為に値を保存
            returnTextArray.append("ここに翻訳履歴が入ります。")
            returnTextArray.append("最新10件までを表示します。")
            
            // ローカルに保存
            UserDefaults.standard.set(returnTextArray, forKey: "returnTextArray")
        }
        
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
    
    // Pickerのツールバーのdoneボタンをタップした場合に呼ばれる
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
                                          message: "原文を入力またはペーストして下さい")
            
            // アラートのアクションを設定しアラートを追加
            let doneAction = EMAlertAction(title: "やり直す", style: .normal)
            alert.addAction(doneAction)
            
            // アラートの表示
            present(alert, animated: true, completion: nil)
        } else {
            
            // beforTextViewのテキストを読み取ってTranslationModelと通信をおこなう
            let translationModel = TranslationModel(Key: TRANSLATION_KEY, version: TRANSLATION_VER, url: TRANSLATION_URL, text: beforTextView.text)
            
            // languageに値を保存する処理を分岐
            switch language == nil {
            
            
            // MARK: - 原文英語
            // 原文が英語で訳文が日本語の場合
            case beforLanguageText!.text == "英語" && afterLanguageText!.text == "日本語":
                language = "en-ja"
                translationModel.startTranslation(language: language!)
                
                
            // MARK: - 原文日本語
            // 原文が日本語で訳文が英語の場合
            case beforLanguageText!.text == "日本語" && afterLanguageText!.text == "英語":
                language = "ja-en"
                translationModel.startTranslation(language: language!)
            default:
                // アラートのインスタンス
                let alert = EMAlertController(icon   : UIImage(named: "キャンセル"),
                                              title  : "翻訳できません",
                                              message: "原文と訳文の言語を選択して下さい")
                
                // アラートのアクションを設定しアラートを追加
                let doneAction = EMAlertAction(title: "やり直す", style: .normal)
                alert.addAction(doneAction)
                
                // アラートの表示
                present(alert, animated: true, completion: nil)
            }
            // デリゲートを委託
            translationModel.returnTranslationText = self
        }
    }
    
    
    // MARK: - 翻訳終了処理
    // TranslationModelから値を受け取る
    func returnTranslationText(text: String) {
        
        // 次の翻訳に備えて値をnilに
        language = nil
        
        // 翻訳結果のインスタンス作成
        let returnText = text
        
        // 履歴ページで扱う配列の構築
        if UserDefaults.standard.array(forKey: "returnTextArray")!.count < 10 {
            
            // 翻訳結果10件までを新しい順に若番に保存
            returnTextArray.insert(returnText, at: Count.zero)
            
            // ローカルに値を保存
            UserDefaults.standard.set(returnTextArray, forKey: "returnTextArray")
        } else {
            
            // 配列の最後の要素を削除して
            var array = UserDefaults.standard.array(forKey: "returnTextArray")
                array?.removeLast()
            
            // 配列の頭に値を保存
            array!.insert(returnText, at: Count.zero)
            
            // ローカルに値を保存
            UserDefaults.standard.set(array, forKey: "returnTextArray")
        }
            
        // 翻訳結果をViewに反映
        DispatchQueue.main.async {
            self.afterTextView.text = returnText
        }
    }
    
    
    // MARK: - 読み上げ機能
    // 読み上げボタンをタップすると呼ばれる
    @IBAction func tapSpeechButton(_ sender: Any) {
        
        // 原文がnilの場合はアラートを表示
        if afterTextView.text == "" {
            
            // アラートのインスタンス
            let alert = EMAlertController(icon   : UIImage(named: "キャンセル"),
                                          title  : "読み上げできません",
                                          message: "翻訳後に再度タップして下さい")
            
            // アラートのアクションを設定しアラートを追加
            let doneAction = EMAlertAction(title: "やり直す", style: .normal)
            alert.addAction(doneAction)
            
            // アラートの表示
            present(alert, animated: true, completion: nil)
        } else {
            
            // ReturnLanguageCodeModelへ値を渡して通信
            let returnLanguageCodeModel = ReturnLanguageCodeModel(id: Count.zero, text: afterTextView.text)
                returnLanguageCodeModel.startIdentifyLanguage()
            
            // デリゲートを委託
            returnLanguageCodeModel.doneCatchReturnLanguageCode = self
        }
    }
    
    // 言語コードを受け取ってSpeechModelへ値を渡す
    func doneCatchReturnLanguageCode(cellNum: Int, languageCode: String) {
        
        // SpeechModelへ値を渡して通信
        let speechModel = SpeechModel(text: afterTextView.text)
            speechModel.startSpeech(code: languageCode)
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
    
    // キーボードのPickerのdoneがタップされると呼ばれる
    @objc func doneKeyboard() {
        // キーボードーを閉じる
        self.view.endEditing(true)
    }
}

