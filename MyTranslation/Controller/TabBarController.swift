//
//  TabBarController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/02.
//

import UIKit

// TabBarをカスタムするクラス
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // アプリ起動時のTabBarItemの色
        UITabBar.appearance().tintColor = UIColor.systemGreen
        
        // TabBarの背景色
        tabBar.backgroundColor = UIColor.white
        
        // TabBarの背景がすりガラスのようになるので防止
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    // Tabをタップした場合のアクション
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Tabのtagで処理を分岐
        switch item.title {
        case "ホーム":
            UITabBar.appearance().tintColor = UIColor.systemGreen
        default:
            // TabBarItem非選択時の色
            tabBar.unselectedItemTintColor =  UIColor.gray
        }
    }
}
