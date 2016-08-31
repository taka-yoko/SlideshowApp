//
//  ViewController.swift
//  SlideshowApp
//
//  Created by tyoko on 2016/08/25.
//  Copyright © 2016年 takayoshi.yokoyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //再生ボタン
    @IBOutlet weak var startButton: UIButton!
    
    //進むボタン
    @IBOutlet weak var nextButton: UIButton!
    
    //戻るボタン
    @IBOutlet weak var prevButton: UIButton!
    
    //画像を表示するUIImageView
    @IBOutlet weak var imageView: UIImageView!
    
    //画像の配列
    var imageList = ["img_1_s.jpg", "img_2_s.jpg", "img_3_s.jpg"]
    //画像の配列の数
    var imageLength = 0
    //画像インデックス
    var imageIndex = 0
    //タイマー
    var timer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: imageList[0])
        imageView.image = image
        imageLength = imageList.count
        
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))
        
    }
    
    //タイマー初期化
    func timerInitialized(){
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.onTimer(_:)), userInfo: nil, repeats: true)
    }
    
    //タイマー実行時に繰り返されるメソッド
    func onTimer(timer: NSTimer){
        imageIndex = indexChange(1, index: imageIndex, length: imageLength)
        displayImage(imageIndex)
    }
    
    //タイマー開始
    func timerStart(){
        if(timer!.valid){
            timerInitialized()
        }
    }
    
    //タイマーストップ
    func timerStop(){
        if(timer!.valid){
            timer?.invalidate()
        }
    }
    
    //進む
    func goNext(){
        imageIndex = indexChange(1, index: imageIndex, length: imageLength)
        displayImage(imageIndex)
    }
    
    //戻る
    func goPrev(){
        imageIndex = indexChange(-1, index: imageIndex, length: imageLength)
        displayImage(imageIndex)
    }
    
    //引数で渡されたインデックスの画像を表示する
    func displayImage(index:Int){
        let name = imageList[index]
        let image = UIImage(named: name)
        imageView.image = image
        
    }
    
    
    //画像のインデックスを変更する
    func indexChange(num:Int, index:Int, length:Int) -> Int {
        return (index + num + length) % length
    }
    
    //再生ボタン押下時のイベント
    @IBAction func tappedButton(sender: AnyObject) {
        if(timer == nil || !(timer!.valid)){ //停止中または初回再生ボタン押下ならば再生
            timerInitialized()
            startButton.setTitle("停止", forState: UIControlState.Normal)
            //進む・戻るボタンの無効化
            nextButton.enabled = false
            prevButton.enabled = false
        }else{   //再生中ならば停止
            timer!.invalidate()
            startButton.setTitle("再生", forState: UIControlState.Normal)
            //進む・戻るボタンの有効化
            nextButton.enabled = true
            prevButton.enabled = true
        }
    }
    
    //進むボタン押下時のイベント
    @IBAction func tappedNextButton(sender: AnyObject) {
        goNext()
    }
    
    //戻るボタン押下時のイベント
    @IBAction func tappedPrevButton(sender: AnyObject) {
        goPrev()
    }
    
    //画像タップ時に画面遷移する
    func imageTapped(sender: UITapGestureRecognizer){
        self.delegate.imageIndex = imageIndex
        //let imageViewController:UIViewController = ImageViewController()
        let imageViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ImageViewController") as UIViewController
        self.presentViewController(imageViewController, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        
    }

}

