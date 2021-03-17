//
//  MenuViewController.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/05.
//

import UIKit
import StoreKit
import MessageUI

// メニューページを扱うクラス
class MenuViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    // MARK: - プロパティ
    // メニューボックスのインスタンス
    @IBOutlet weak var reviewBox: UIView!
    @IBOutlet weak var mailBox: UIView!
    @IBOutlet weak var twitterBox: UIView!
    @IBOutlet weak var versionBox: UIView!
    
    // レビューラベルのインスタンス
    @IBOutlet weak var reviewLabel: UILabel!
    
    // お問い合わせラベルのインスタンス
    @IBOutlet weak var mailLabel: UILabel!
    
    // Twitter紹介ラベルのインスタンス
    @IBOutlet weak var twitterLabel: UILabel!
    
    // バージョン紹介ラベルのインスタンス
    @IBOutlet weak var versionLabel: UILabel!
    
    // ラベルに表示するテキストの配列
    var menuTextArray = ["レビュー", "お問い合わせ", "開発者", "Version 1.0"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ダークモード適用を回避
        self.overrideUserInterfaceStyle = .light

        // ラベルにテキストを反映
        reviewLabel.text  = menuTextArray[Count.zero]
        mailLabel.text    = menuTextArray[Count.one]
        twitterLabel.text = menuTextArray[Count.two]
        versionLabel.text = menuTextArray[Count.three]
        
        // パーツの配色設定（ベースカラー）
        view.backgroundColor       = ColorList.baseColor
        reviewBox.backgroundColor  = ColorList.baseColor
        mailBox.backgroundColor    = ColorList.baseColor
        twitterBox.backgroundColor = ColorList.baseColor
        versionBox.backgroundColor = ColorList.baseColor
        
        // メニューボックスの枠線の色
        reviewBox.layer.borderColor  = ColorList.itemColor.cgColor
        mailBox.layer.borderColor    = ColorList.itemColor.cgColor
        twitterBox.layer.borderColor = ColorList.itemColor.cgColor
        versionBox.layer.borderColor = ColorList.itemColor.cgColor
        
        // メニュー枠線の太さ
        reviewBox.layer.borderWidth  = CGFloat(Count.one)
        mailBox.layer.borderWidth    = CGFloat(Count.one)
        twitterBox.layer.borderWidth = CGFloat(Count.one)
        versionBox.layer.borderWidth = CGFloat(Count.one)
        
        // メニューボックスの角丸
        reviewBox.layer.cornerRadius  = CGFloat(CornerRadius.size)
        mailBox.layer.cornerRadius    = CGFloat(CornerRadius.size)
        twitterBox.layer.cornerRadius = CGFloat(CornerRadius.size)
        versionBox.layer.cornerRadius = CGFloat(CornerRadius.size)
    }
    
    
    // MARK: - メニュータップアクション
    // レビューボックスをタップすると呼ばれる
    @IBAction func tapReviewButton(_ sender: Any) {
        
        // レビューを求めるアクションを表示
        SKStoreReviewController.requestReview()
    }
    
    // お問い合わせボックスをタップすると呼ばれる
    @IBAction func tapMailButton(_ sender: Any) {
        
        // メールを送信できるかどうかの確認
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        // インスタンスの作成と委託
        let mailViewController = MFMailComposeViewController()
            mailViewController.mailComposeDelegate = self
        
        // 宛先の設定
        let toRecipients = ["nkeiisasa222@gmail.com"]
        
        // 件名と宛先の表示
        mailViewController.setSubject("『俺の翻訳』へのお問い合わせ")
        mailViewController.setToRecipients(toRecipients)
        mailViewController.setMessageBody("▼アプリの不具合などの連絡はこちら \n \n \n \n ▼機能追加依頼はこちら \n \n \n \n ▼その他ご要望はこちら", isHTML: false)
        
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    // メール機能終了処理
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // メールの結果で条件分岐
        switch result {
        
        // キャンセルの場合
        case .cancelled:
            print("Email Send Cancelled")
            break
            
        // 下書き保存の場合
        case .saved:
            print("Email Saved as a Draft")
            break
            
        // 送信成功の場合
        case .sent:
            print("Email Sent Successfully")
            break
            
        // 送信失敗の場合
        case .failed:
            print("Email Send Failed")
            break
        default:
            break
        }
        //メールを閉じる
        controller.dismiss(animated: true, completion: nil)
    }
    
    // Twitter紹介ボックスをタップすると呼ばれる
    @IBAction func tapTwitterButton(_ sender: Any) {
        
        // 開発者のTwitterアカウントをURL型で定義
        let twitterURL = URL(string: "https://twitter.com/ken_sasaki2")
        
        // twitterURLで遷移、ユーザーのTwitterアカウントが存在しない場合は作成を促す
        if UIApplication.shared.canOpenURL(twitterURL! as URL) {
            UIApplication.shared.open(twitterURL! as URL, options: [:], completionHandler: nil)
        }
    }
}
