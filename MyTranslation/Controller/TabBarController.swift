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
        
        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light

        // アプリ起動時のTabBarItemの色
        UITabBar.appearance().tintColor = ColorList.itemColor
        
        // TabBarの背景色
        tabBar.backgroundColor = ColorList.baseColor
        
        // 境界線の透過
        UITabBar.appearance().shadowImage = UIImage()
        
        // TabBarの背景がすりガラスのようになるので防止
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    // Tabをタップした場合のアクション
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        // Tabのtagで処理を分岐
        switch item.title {
        case "ホーム":
            UITabBar.appearance().tintColor = ColorList.itemColor
        default:
            // TabBarItem非選択時の色
            tabBar.unselectedItemTintColor = ColorList.notSelectColor
        }
    }
}
