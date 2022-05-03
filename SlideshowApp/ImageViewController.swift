//
//  ImageViewController.swift
//  SlideshowApp
//
//  Created by 中嶋淳 on 2022/05/03.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var pictNo:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let targetPic = UIImage(named: "pic0" + String(pictNo) + ".jpeg")
        imageView.image = targetPic
    }
}
