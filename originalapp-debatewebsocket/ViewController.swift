//
//  ViewController.swift
//  originalapp-debatewebsocket
//
//  Created by Leon Iwami on 2016/02/16.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

// 送信
// "text:hogehoge"->メッセージ"hogehoge"を送る
// "vote:0/1"->投票する（0/1）
// "end"->投票終了
// 受信
// "text:hogehoge"->メッセージ"hogehoge"を受信する
// "vote"->"誰かが投票した"
// "result:0-35,1-11"->0が35人、1が11人

import UIKit
import QuartzCore
import UNAlertView

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var timerlabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var story1: UILabel!
    var storymessage: String?
    @IBOutlet var red: UILabel!
    var votechoicered: String?
    @IBOutlet var blue: UILabel!
    var votechoiceblue: String?
    
    var socket = WebSocket(url: NSURL(string:"wss://sinatra-websocket-leoniwami.c9users.io/websocket")!)
    var mt :[String] = [];
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var sec: Int = 0
    var min: Int = 0
    var hour: Int = 0
    var timer: NSTimer = NSTimer()
    
    var firsttimer = UITableView()
    
    
    @IBAction func send() {
        //self.socket.writeString(message.text!)
        self.socket.writeString("text:" + message.text!)
        message.text = "";
    }
    
    //タイマー
    @IBAction func start() {
        if !timer.valid {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.up), userInfo: nil, repeats: true)
            
        let alert: UIAlertController = UIAlertController(title: "開始・再開", message: "討論を開始してください！", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true) { () -> Void in
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        }
    }
    
    func up() {
        sec = sec + 1
        let hour = sec / 3600
        let min = sec % 3600 / 60
        let second = sec % 60
        timerlabel.text = String(hour) + "時間" + String(min) + "分" + String(second) + "秒"
    }
    
    
    @IBAction func stop() {
        if timer.valid {
            timer.invalidate()
            
        let alert: UIAlertController = UIAlertController(title: "一時停止", message: "討論を中断します。", preferredStyle: .Alert)
        self.presentViewController(alert, animated: true) { () -> Void in
            let delay = 2.0 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        story1.text = storymessage
        red.text = votechoicered
        blue.text = votechoiceblue
        
        
        let alertView = UNAlertView(title: "はじめの投票", message: "自分の意思だけで投票")
        alertView.addButton("青",
                            backgroundColor: UIColor(red: 0, green: 0, blue: 255, alpha: 0.5),
                            fontColor: UIColor.whiteColor(),
                            action: {
                                print("Some Action")
        })
        
        alertView.addButton("赤",
                            backgroundColor: UIColor(red: 255, green: 0, blue: 0, alpha: 0.5),
                            fontColor: UIColor.whiteColor(),
                            action: {
                                print("Some Action")
        })
 
        alertView.show()
        
        let datePickerView = DatePickerSubView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.5))
        datePickerView.center.x = self.view.center.x
        datePickerView.center.y = self.view.center.y
        datePickerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        self.view.addSubview(datePickerView)
        
        //消す
//        datePickerView.removeFromSuperview()
        
        //投票アラート
//        let alert: UIAlertController = UIAlertController(title: "初めの投票", message: "素直に自分の意思でどちらか選ぼう。", preferredStyle: .Alert)
//        alert.addAction(
//            UIAlertAction(
//                title: "BLUE", style: UIAlertActionStyle.Default, handler: {action in
//                
//                    self.navigationController!.popViewControllerAnimated(true)
//                }
//            )
//        )
//        alert.addAction(
//            UIAlertAction(
//                title: "RED", style: UIAlertActionStyle.Default, handler: {action in
//                
//                    self.navigationController?.popViewControllerAnimated(true)
//                }
//            )
//        )
//        self.presentViewController(alert, animated: true, completion: nil)
        
        tableview.dataSource = self
        tableview.delegate = self
        
        let nib = UINib(nibName: "tableTableViewCell1", bundle: nil)
        self.tableview.registerNib(nib, forCellReuseIdentifier: "Cell1")
        
        self.socket.connect()
        self.socket.onText = { p -> () in
            let header = (p as NSString).substringToIndex(5)
            let body = (p as NSString).substringFromIndex(5)
            if header == "text:" {
                self.mt.append(body)
                print(self.mt)
                self.defaults.setObject(self.mt, forKey: "openKey")
                self.tableview.reloadData()
            }else if header == "vote:" {
                self.mt.append("だれかが" + "『" + body + "』" + "に変更されました。")
                let alert: UIAlertController = UIAlertController(title: "投票の変更", message: "『" + body + "』" + "に変更。", preferredStyle: .Alert)
                self.presentViewController(alert, animated: true) { () -> Void in
                    let delay = 1.0 * Double(NSEC_PER_SEC)
                    let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }
                self.defaults.setObject(self.mt, forKey: "openKey")
                self.tableview.reloadData()
            }
        }
        
//        //昔"openKey"という鍵で保存したかどうか確認
//        if((defaults.objectForKey("openKey")) != nil){
//            //objectsを配列として確定させ、前回の保存内容を格納
//            self.mt = (defaults.objectForKey("openKey") as? [String])!
//            tableview.reloadData()
//        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mt.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell1") as!
        tableTableViewCell1
        cell.textmessage.text = mt[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let voteViewController:VoteViewController = segue.destinationViewController as! VoteViewController
        voteViewController.socket = self.socket
    }
    
}

