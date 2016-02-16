//
//  ViewController.swift
//  originalapp-debatewebsocket
//
//  Created by Leon Iwami on 2016/02/16.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    //@IBOutlet weak var label1: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var message: UITextField!
    
    var socket = WebSocket(url: NSURL(string:"wss://sinatra-websocket-leoniwami.c9users.io/websocket")!)
    var mt :[String] = [];
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func send() {
        self.socket.writeString(message.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.delegate = self
        
        let nib = UINib(nibName: "tableTableViewCell1", bundle: nil)
        self.tableview.registerNib(nib, forCellReuseIdentifier: "Cell1")
        
        self.socket.connect()
        self.socket.onText = { p -> () in
            self.mt.append(p)
            self.defaults.setObject(self.mt, forKey: "openKey")
            self.tableview.reloadData()
        }
        
        //昔"openKey"という鍵で保存したかどうか確認
        if((defaults.objectForKey("openKey")) != nil){
            //objectsを配列として確定させ、前回の保存内容を格納
            self.mt = (defaults.objectForKey("openKey") as? [String])!
            tableview.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return mt.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: tableTableViewCell1 = tableView.dequeueReusableCellWithIdentifier("tableTableViewCell1", forIndexPath: indexPath) as! tableTableViewCell1
        
        cell.textmessage.text = mt[indexPath.row]
        return cell
    }

}

