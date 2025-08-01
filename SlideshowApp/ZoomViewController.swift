//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by ynagaro on 2025/08/02.
//

import UIKit

class ZoomViewController: UIViewController {
    
    @IBOutlet weak var ZoomImageView: UIImageView!
    // 画面遷移時に画像を受け取るプロパティ
    var imageToZoom: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画像をセット
        ZoomImageView.image = imageToZoom
    }
    
    // 閉じるボタン
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
