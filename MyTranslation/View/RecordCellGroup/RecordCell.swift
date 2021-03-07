//
//  RecordCell.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/04.
//

import UIKit

// RecordCellを扱うクラス
class RecordCell: UITableViewCell {
   
    // 履歴を表示するラベル
    @IBOutlet weak var recordLabel: UILabel!
    
    // セル本体
    @IBOutlet weak var recordCell: UIView!
    
    // 履歴件数を表示するラベル
    @IBOutlet weak var recordCountLabel: UILabel!
    
    // 履歴テキストを読み上げるボタン
    @IBOutlet weak var recordSpeechButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // ボタンの背景色
        recordSpeechButton.tintColor = ColorList.accentIndigo
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - 履歴読み上げ機能
    // 音量アイコンをタップすると呼ばれる
    @IBAction func tapRecordSpeechButton(_ sender: Any) {
        print("履歴読み上げ")
    }
    
}
