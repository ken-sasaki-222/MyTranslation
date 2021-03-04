//
//  RecordViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/04.
//

import UIKit

// 履歴ページを扱うクラス
class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // やること
    // カスタムセルを用いてセルを構築 ✔︎
    // TabをHomeVCと合わせてカスタム ✔︎
    // アプリ内に値を保存してそれを反映

    
    // MARK: - プロパティ
    // TableViewのインスタンス
    @IBOutlet weak var recordTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light
        
        // パーツの配色設定（ベースカラー）
        recordTableView.backgroundColor = ColorList.baseColor
        
        // デリゲートを委託
        recordTableView.delegate   = self
        recordTableView.dataSource = self
        
        // カスタムセルを委託
        recordTableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "recordCell")
    }
    
    
    // MARK: - TableViewの設定
    // セクションの数を決める
    func numberOfSections(in tableView: UITableView) -> Int {
        return Count.one
    }
    
    // セルの数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // セルを構築する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordCell
        
        // セルの背景色
        cell.recordCell.backgroundColor = ColorList.baseColor
        
        // セルのタップを無効化
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // 空のセルを削除
        recordTableView.tableFooterView = UIView(frame: .zero)
        
        return cell
    }
}
