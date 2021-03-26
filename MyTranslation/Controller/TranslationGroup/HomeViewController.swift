//
//  ViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/01.
//

import UIKit
import EMAlertController
import AVFoundation
import SegementSlide


// テキスト入力による翻訳をおこなうクラス
class HomeViewController: UIViewController, ReturnTranslationText, DoneCatchReturnLanguageCode, SegementSlideContentScrollViewDelegate, AVSpeechSynthesizerDelegate {
    
    
    // MARK: - プロパティ
    // テキストビュー（原文）
    @IBOutlet weak var beforTextView: UITextView!
    
    // テキストビュー（訳文）
    @IBOutlet weak var afterTextView: UITextView!
    
    // テキスト読み上げを開始するボタン
    @IBOutlet weak var speeshButton: UIButton!
    
    // 言語設定Label（原文）
    @IBOutlet weak var beforeLanguage: UILabel!
    
    // 言語設定Label（訳文）
    @IBOutlet weak var afterLanguage: UILabel!
    
    // 原文-訳文をクリアするボタン
    @IBOutlet weak var freshButton: UIButton!
    
    // 原文-訳文を保存してModelへ渡す
    var language: String?
    
    // 翻訳履歴を保存する配列
    var returnTextArray: [String] = []
    
    // 読み上げ機能で扱う
    var talker = AVSpeechSynthesizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        
        // viewの背景色
        view.backgroundColor = UIColor(hex: "f4f8fa")
        
        // テキストビューの化粧
        beforTextView.backgroundColor = ColorList.mainColor
        afterTextView.backgroundColor = ColorList.mainColor
        
        // 訳文テキストビューはキーボードを出現させない
        afterTextView.isUserInteractionEnabled = true
        afterTextView.isEditable = false
        
        // 言語設定Labelの初期値
        beforeLanguage.text = "英語 🇬🇧"
        afterLanguage.text  = "日本語 🇯🇵"
    
        // 言語設定Labelの化粧
        afterLanguage.layer.cornerRadius  = CGFloat(CornerRadius.size)
        afterLanguage.clipsToBounds       = true
        beforeLanguage.layer.cornerRadius = CGFloat(CornerRadius.size)
        beforeLanguage.clipsToBounds      = true
    
        // アイコンボタンの化粧（クリアボタン, 翻訳ボタン, 読み上げボタン）
        freshButton.tintColor            = UIColor(hex: "1e90ff")
        speeshButton.tintColor           = UIColor(hex: "1e90ff")
        
        // ローカルに保存されている翻訳履歴が空であれば呼ばれる
        if  UserDefaults.standard.array(forKey: "returnTextArray") == nil {
            
            // エラー回避の為に値を保存
            returnTextArray.append("ここに翻訳履歴が入ります。")
            returnTextArray.append("最新10件までを表示します。")
            
            // ローカルに保存
            UserDefaults.standard.set(returnTextArray, forKey: "returnTextArray")
        }
        
        // キーボードのツールバーを反映
        createKeyboardButton()
        
        // デリゲートの委託
        self.talker.delegate = self
    }
    
    
    // MARK: - キーボードにツールバーを追加
    // "閉じる", "翻訳"ボタンをキーボードに追加
    func createKeyboardButton() {
        
        // ツールバーを作成
        let toolbar = UIToolbar()
            toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        
        // 余白用アイテム
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        // "閉じる"ボタンを作成
        let doneButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneKeyboard))
        
        // "クリア"ボタンを作成
        let crearButtonItem = UIBarButtonItem(title: "クリア", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapCrearButtonItem))
        
        // "翻訳実行"ボタンを作成
        let translationButtonItem = UIBarButtonItem(title: "翻訳実行", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapStartTranslation))
        
        // ツールバーにボタンを反映（閉じる, クリア, 翻訳実行）
        toolbar.setItems([doneButtonItem, flexibleItem, crearButtonItem, flexibleItem, translationButtonItem], animated: true)
        
        // ツールバーを反映
        beforTextView.inputAccessoryView = toolbar
    }
    
    
    // MARK: - 翻訳言語変更
    // 中央矢印ボタンをタップすると呼ばれる
    @IBAction func changeLanguageButton(_ sender: Any) {
        
        // 原文と訳文の言語を変換する
        if beforeLanguage.text == "英語 🇬🇧" && afterLanguage.text == "日本語 🇯🇵" {
            beforeLanguage.text = "日本語 🇯🇵"
            afterLanguage.text  = "英語 🇬🇧"
        } else {
            beforeLanguage.text = "英語 🇬🇧"
            afterLanguage.text  = "日本語 🇯🇵"
        }
    }
    

    // MARK: - 翻訳開始
    // 翻訳実行をタップすると呼ばれる
    @objc func tapStartTranslation() {
        
        // キーボードを閉じる
        self.view.endEditing(true)
        
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
            case beforeLanguage.text == "英語 🇬🇧" && afterLanguage.text == "日本語 🇯🇵":
                language = "en-ja"
                translationModel.startTranslation(language: language!)
                
                
            // MARK: - 原文日本語
            // 原文が日本語で訳文が英語の場合
            case beforeLanguage.text == "日本語 🇯🇵" && afterLanguage.text == "英語 🇬🇧":
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
            
            // 読み上げボタンのタップを拒否(連続タップを防止)
            speeshButton.isEnabled = false
            
            // ReturnLanguageCodeModelへ値を渡して通信
            let returnLanguageCodeModel = ReturnLanguageCodeModel(id: Count.zero, text: afterTextView.text)
                returnLanguageCodeModel.startIdentifyLanguage()
            
            // デリゲートを委託
            returnLanguageCodeModel.doneCatchReturnLanguageCode = self
        }
    }
    
    // 言語コードを受け取ってテキストを読み上げ
    func doneCatchReturnLanguageCode(cellNum: Int, languageCode: String) {
        
        // 話す内容をセット
        let utterance = AVSpeechUtterance(string: afterTextView.text)
        
        // 言語を設定
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        
        // 実行
        self.talker.speak(utterance)
    }

    // 読み上げ終了時に呼ばれる
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("読み上げ終了")
        
        // 読み上げボタンのタップ許可
        speeshButton.isEnabled = true
    }
    
    
    // MARK: - クリアアクション
    // クリアボタンをタップすると呼ばれる
    @IBAction func tapclearButton(_ sender: Any) {
        beforTextView.text = nil
        afterTextView.text = nil
    }
    
    // ツールバーのクリアボタンをタップすると呼ばれる
    @objc func tapCrearButtonItem() {
        beforTextView.text = nil
        afterTextView.text = nil
    }
    
    
    // MARK: - 入力アクションを閉じる
    // Viewタップ閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    
    // キーボードの"閉じる"ボタンがタップされると呼ばれる
    @objc func doneKeyboard() {
        // キーボードを閉じる
        self.view.endEditing(true)
    }
}

