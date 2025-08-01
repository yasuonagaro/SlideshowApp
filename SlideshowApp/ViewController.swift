//
//  ViewController.swift
//  SlideshowApp
//
//  Created by ynagaro on 2025/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var back: UIButton!
    
    let imageData: [String] = ["quokka","koala","bird"] // 画像をリストに格納
    var imageCurrentIndex: Int = 0 // 画像を指定する初期インデックスを0
    var timer: Timer! //タイマー
    var isAutoplaying = false //自動再生有無のフラグ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = UIImage(named: imageData[imageCurrentIndex]) //インデックス0の画像を表示
        ImageView.isUserInteractionEnabled = true //画像をタップ可能にする
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        ImageView.addGestureRecognizer(tapGesture)
    }
    
    //進むボタン
    @IBAction func forward(_ sender: UIButton) {
        playbackcontrol(forward: true)
    }
    
    //戻るボタン
    @IBAction func back(_ sender: UIButton) {
        playbackcontrol(forward: false)
    }
    
    //自動再生・停止ボタン
    @IBAction func playAndPause(_ sender: UIButton) {
        // 自動再生停止中の場合
        if !isAutoplaying {
            isAutoplaying = true
            sender.setTitle("停止", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(forward(_:)), userInfo: nil, repeats: true)
            forward.isEnabled = false //自動再生停止中は進むボタンを押せないようにする
            back.isEnabled = false   // 自動再生停止中は戻るボタンを押せないようにする
        // 自動再生中の場合
        } else {
            isAutoplaying = false
            timer.invalidate()
            sender.setTitle("再生", for: .normal)
            forward.isEnabled = true //自動再生停止中は進むボタンを押せるようにする
            back.isEnabled = true   // 自動再生停止中は戻るボタンを押せるようにする
        }
    }
    
    //画像自動再生
    @objc func autoPlayingUpdateImage() {
        playbackcontrol(forward: true)
    }
    
    //次の画像表示の制御
    @objc func playbackcontrol(forward: Bool = true) {
        // 画像送りが順方向の場合
        if forward {
            // インデックスが範囲外にならない場合は次に進む
            if imageCurrentIndex < imageData.count - 1 {
                imageCurrentIndex += 1
                ImageView.image = UIImage(named: imageData[imageCurrentIndex])
            }
            // そうでない場合、最初に戻る
            else {
                imageCurrentIndex = 0
                ImageView.image = UIImage(named: imageData[imageCurrentIndex])
            }
        }
        // 画像送りが逆順の場合
        else {
            // インデックスが範囲外にならない場合は後ろに進む
            if imageCurrentIndex > 0 {
                imageCurrentIndex -= 1
                ImageView.image = UIImage(named: imageData[imageCurrentIndex])
            }
            // そうでない場合、最後に戻る
            else {
                imageCurrentIndex = imageData.count - 1
                ImageView.image = UIImage(named: imageData[imageCurrentIndex])
            }
        }
    }
    
    // 画像タップ
    @objc func imageTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let zoomViewController = storyboard.instantiateViewController(withIdentifier: "ZoomViewController") as! ZoomViewController

        // 拡大表示したい画像を次の画面に渡す
        zoomViewController.imageToZoom = ImageView.image
        
        // モーダルで画面を表示
        present(zoomViewController, animated: true, completion: nil)
    }
}
