//
//  SegementViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/22.
//

import UIKit
import SegementSlide


// 各ViewControllerを扱うクラス
class SegementViewController: SegementSlideDefaultViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スライドの更新
        reloadData()
        
        // スライドの初期位置（最左）
        defaultSelectedIndex = Count.zero
        
        // Navigationbarを反映
        setNewsNavigationBar()
    }
    
    // MARK: - Navigation
    // NavigationBarの設定
    func setNewsNavigationBar() {
        
        // NavigationBarのタイトルとその色とフォント
        navigationItem.title = "俺の翻訳"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorList.itemColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19.0, weight: .semibold)]
        
        // NavigationBarの色
        self.navigationController?.navigationBar.barTintColor = ColorList.baseColor
        
        // 一部NavigationBarがすりガラス？のような感じになるのでfalseで統一
        self.navigationController?.navigationBar.isTranslucent = false
        
        // NavigationBarの下線を削除
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    // MARK: - SegementSlideの設定
    // スライドのタイトルを決める
    override var titlesInSwitcher: [String] {
        return ["ホーム", "履歴", "メニュー"]
    }
    
    // スライドにControllerを返す
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case Count.zero:
            
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            return homeVC
        case Count.one:
            let recordVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recordVC") as! RecordViewController
            return recordVC
        case Count.two:
            
            let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
            return menuVC
        default:
            
            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            return homeVC
        }
    }
}
