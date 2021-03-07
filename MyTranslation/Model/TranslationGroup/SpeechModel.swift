//
//  SpeechModel.swift
//  MyTranslation
//
//  Created by 佐々木　謙 on 2021/03/07.
//

import Foundation
import AVFoundation

// テキスト読み上げをおこなうクラス
class SpeechModel {
    
    
    // MARK: - プロパティ
    // 読み上げ機能で扱う
    var talker = AVSpeechSynthesizer()
    
    // Controllerから受け取った値を保存する
    var speechText: String
    
    // Controllerから渡ってくる値を受け取る
    init(text: String) {
    
        speechText = text
    }
    
    
    // MARK: - テキスト読み上げを開始する
    func startSpeech() {
        
        // 話す内容をセット
        let utterance = AVSpeechUtterance(string: speechText)
        
        // 言語を設定
        utterance.voice = AVSpeechSynthesisVoice(language: "en")
        
        // 実行
        self.talker.speak(utterance)
    }
}
