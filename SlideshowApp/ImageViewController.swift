//
//  ImageViewController.swift
//  SlideshowApp
//
//  Created by tyoko on 2016/08/26.
//  Copyright © 2016年 takayoshi.yokoyama. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = "img_\(self.delegate.imageIndex + 1)_l.jpg"
        print(name)
        let image = UIImage(named: name)
        imageView.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
