//
//  DatePickerSubView.swift
//  datepicker
//
//  Created by AuraOtsuka on 2016/04/03.
//  Copyright © 2016年 AuraOtsuka. All rights reserved.
//
import UIKit

class DatePickerSubView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Labelを作成.
        let alertname: UILabel = UILabel(frame: CGRectMake(0,0,self.frame.width,40))
        // 背景をオレンジ色にする.
        alertname.backgroundColor = UIColor.init(red: 0.3, green: 0.6, blue: 0.8, alpha: 0.5)
        // 枠を丸くする.
        alertname.layer.masksToBounds = true
        alertname.layer.cornerRadius = 5.0
        // Labelに文字を代入.
        alertname.text = "とりあえず時間を決めよ"
        // 文字の色を白にする.
        alertname.textColor = UIColor.whiteColor()
        // 文字の影の色をグレーにする.
        alertname.shadowColor = UIColor.grayColor()
        // Textを中央寄せにする.
        alertname.textAlignment = NSTextAlignment.Center
        // ViewにLabelを追加.
        self.addSubview(alertname)
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.frame = CGRectMake(0, 40, self.frame.width, self.frame.height-40)
        myDatePicker.timeZone = NSTimeZone.localTimeZone()
        myDatePicker.backgroundColor = UIColor.init(red: 1.0, green: 0.3, blue: 0.1, alpha: 0.1)
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.3
        myDatePicker.datePickerMode = .CountDownTimer
        
        self.addSubview(myDatePicker)
        // 値が変わった際のイベントを登録する.
        //myDatePicker.addTarget(self, action: "onDidChangeDate:", forControlEvents: .ValueChanged)
        
        // DataPickerをViewに追加する
        
        let timestart: UIButton = UIButton(frame: CGRectMake(0,myDatePicker.frame.height+40,self.frame.width,50))
        timestart.backgroundColor = UIColor.init(red: 0.3, green: 0.6, blue: 0.8, alpha: 0.5)
        //タイトルを設定する(通常時).
        timestart.setTitle("Are You Ready ?!", forState: UIControlState.Normal)
        timestart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        timestart.setTitle("Let's Start !", forState: UIControlState.Highlighted)
        timestart.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        timestart.layer.cornerRadius = 5.0
        
//        startthetimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.up), userInfo: nil, repeats: true)
//
//        // イベントを追加する.
//        timestart.addTarget(self, action: startthetimer, forControlEvents: .TouchUpInside)
        self.addSubview(timestart)
    
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
