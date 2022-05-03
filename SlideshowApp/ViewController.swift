//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 中嶋淳 on 2022/05/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var playStopBtn: UIButton!
    
    // 画像枚数
    var picCnt: Int = 1
    // タイマー
    var timer: Timer!
    // 画像切り替え秒数
    let intervalSec: Double = 2.0
    // 自動再生モードフラグ
    var autoDisplay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 初期時は「再生」ボタンを表示
        self.playStopBtn.setTitle("再生", for: .normal)
        // 初期表示時に先頭の画像を表示
        self.displayImage()
        
        imageView.isUserInteractionEnabled = true
    }

    // 画像をタップ
    @IBAction func onTapImage(_ sender: Any) {
        // segueを使用して画面を遷移
        performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageViewController:ImageViewController = segue.destination as! ImageViewController
        imageViewController.pictNo = picCnt
        
    }
    // 進むボタン
    @IBAction func forwardBtn(_ sender: Any) {
        // 画像を表示
        self.forwardImage()
    }
    //戻るボタン
    @IBAction func backBtn(_ sender: Any) {
        // 画像を表示
        self.backImage()
    }
    //再生・停止ボタン
    @IBAction func startStopBtn(_ sender: Any) {
        if autoDisplay == true {
            // 停止処理
            if self.timer != nil {
                // タイマーを初期化
                self.timer.invalidate()
                self.timer = nil
            }
            
            // 進む、戻るボタンを有効化
            forwardBtn.isEnabled = true
            backBtn.isEnabled = true
            playStopBtn.setTitle("再生", for: .normal)
            
            autoDisplay = false
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: intervalSec, target: self, selector: #selector(forwardImage), userInfo: nil, repeats: true)
            
            // 進む、戻るボタンを無効化
            forwardBtn.isEnabled = false
            backBtn.isEnabled = false
            
            playStopBtn.setTitle("停止", for: .normal)
            
            autoDisplay = true
        }
    }
    
    // 「進む」時の画像表示
    @objc func forwardImage() {
        if picCnt >= 3 {
            picCnt = 1
        } else {
            picCnt += 1
        }
        displayImage()
    }
    
    // 「戻る」時の画像表示
    @objc func backImage() {
        if picCnt <= 1 {
            picCnt = 3
        } else {
            picCnt -= 1
        }
        displayImage()
    }
    
    // 画像表示処理
    @objc func displayImage() {
        let targetPic = UIImage(named: "pic0" + String(self.picCnt) + ".jpeg")
        imageView.image = targetPic
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

