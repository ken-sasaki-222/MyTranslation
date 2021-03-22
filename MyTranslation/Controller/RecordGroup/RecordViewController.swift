//
//  RecordViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/04.
//

import UIKit
import SegementSlide

// 履歴ページを扱うクラス
class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DoneCatchReturnLanguageCode, SegementSlideContentScrollViewDelegate {
    
    
    // MARK: - プロパティ
    // TableViewのインスタンス
    @IBOutlet weak var recordTableView: UITableView!
    
    // ローカルに保存した翻訳結果を取得する値
    var recordValue: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        
        // デリゲートを委託
        recordTableView.delegate   = self
        recordTableView.dataSource = self
        
        // カスタムセルを委託
        recordTableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "recordCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ローカルに保存した値を取得
        recordValue = UserDefaults.standard.array(forKey: "returnTextArray") as! [String]
        
        // TableViewの更新
        recordTableView.reloadData()
    }
    
    @objc var scrollView: UIScrollView {
        return recordTableView
    }
    
    
    // MARK: - TableViewの設定
    // セクションの数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return Count.one
    }
    
    // セルの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordValue.count
    }
    
    // セルを構築する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordCell
        
        // 履歴件数を反映
        cell.recordCountLabel.text = "▼ \(indexPath.row + Count.one)件前の翻訳"
        cell.recordCountLabel.textColor = ColorList.notSelectColor
        
        // 翻訳結果履歴を反映
        cell.recordLabel.text = recordValue[indexPath.row]
        
        // セルとTableViewの背景色
        cell.recordCell.backgroundColor = ColorList.baseColor
        recordTableView.backgroundColor = ColorList.baseColor
        
        // セルのタップを無効化
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // 空のセルを削除
        recordTableView.tableFooterView = UIView(frame: .zero)
        
        // indexPath.rowを定義しaddTargetで渡してタップアクションを呼ぶ
        cell.recordSpeechButton.tag = indexPath.row
        cell.recordSpeechButton.addTarget(self, action: #selector(tapRecordSpeechButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    // MARK: - 履歴読み上げ機能
    // 音量アイコンをタップすると呼ばれる
    @objc func tapRecordSpeechButton(_ sender: UIButton) {
        
        // indexPath.rowを受け取る
        let speechButtonID = sender.tag
        
        // ReturnLanguageCodeModelへ値を渡して通信
        let returnLanguageCodeModel = ReturnLanguageCodeModel(id: speechButtonID, text: recordValue[speechButtonID])
            returnLanguageCodeModel.startIdentifyLanguage()
        
        // デリゲートを委託
        returnLanguageCodeModel.doneCatchReturnLanguageCode = self
    }
    
    // 言語コードを受け取ってSpeechModelへ値を渡す
    func doneCatchReturnLanguageCode(cellNum: Int, languageCode: String) {
        
        // SpeechModelへ値を渡して通信
        let speechModel = SpeechModel(text: recordValue[cellNum])
            speechModel.startSpeech(code: languageCode)
    }
}
