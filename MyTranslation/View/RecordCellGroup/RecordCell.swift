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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
