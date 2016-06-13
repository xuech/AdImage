//
//  ViewController.swift
//  LaunchImage
//
//  Created by xuech on 16/6/12.
//  Copyright © 2016年 obizsoft. All rights reserved.
//

import UIKit

/// 广告时长
var timeCount : NSInteger = 6

class ViewController: UIViewController {

    var watiTime : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        view.addSubview(lauchImage)
        view.bringSubviewToFront(lauchImage)
        view.addSubview(timeLabel)
    
        watiTime = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:#selector(ViewController.timeClick) , userInfo: nil, repeats: true)
        
        self.performSelector(#selector(ViewController.lanchImageAnimate), withObject: self, afterDelay: Double(timeCount))

    }
    
        /// 懒加载时间空间
    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(self.view.bounds.size.width-50,30,40,20)
        label.backgroundColor = UIColor.redColor()
        label.text = ""
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
        /// 懒加载启动图
    private lazy var lauchImage:UIImageView = {
        var img = UIImageView()
        img = UIImageView(frame:self.view.bounds)
        img.image = UIImage(named: "launchImage.png")
        img.alpha = 0.99
        return img
    }()
    
    private func getLaunchImageName()->String{
        let viewSize = UIScreen.mainScreen().bounds.size
        let viewOrientation = "Portrait"
        var launchImageName = ""
    
        let imagesDict = NSBundle.mainBundle().infoDictionary
        let array = imagesDict!["UILaunchImages"] as! [AnyObject]
        
        for dic in array {
            print(dic)
            let string = dic["UILaunchImageSize"] as! String
            let launchImageOrientation = dic["UILaunchImageOrientation"] as! String
            
            let imageSize = CGSizeFromString(string)
            if CGSizeEqualToSize(imageSize, viewSize) && (viewOrientation == launchImageOrientation){
                launchImageName = launchImageOrientation
            }

            
        }
        return launchImageName
        
    }
    
    /**
     计时器
     */
    func timeClick()  {
        if timeCount > 0 {
            timeCount -= 1
            timeLabel.text = "\(timeCount)"
        }else {
            watiTime?.invalidate()
            watiTime = nil
            timeLabel.removeFromSuperview()
        }
    }
    
    /**
     启动动画
     */
    func lanchImageAnimate()  {
        UIView.animateWithDuration(3.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            var frame = self.lauchImage.frame
            frame.size.width = self.view.bounds.size.width*1.3
            frame.size.height = self.view.bounds.size.height*1.3
            self.lauchImage.frame = frame;
            self.lauchImage.center = self.view.center;
            self.lauchImage.alpha = 0

            }) { (finished) in
                self.lauchImage.removeFromSuperview()
        }
    }

}

