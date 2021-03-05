//
//  RecordViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/04.
//

import UIKit

// 履歴ページを扱うクラス
class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        cell.recordCountLabel.text = "【 \(indexPath.row + Count.one)件前の翻訳 】"
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
        
        return cell
    }
}
