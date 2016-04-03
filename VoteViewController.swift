//
//  VoteViewController.swift
//  originalapp-debatewebsocket
//
//  Created by Leon Iwami on 2016/03/04.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {

    var socket = WebSocket(url: NSURL(string:"wss://sinatra-websocket-leoniwami.c9users.io/websocket")!)
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func vote(mybtn : UIButton) {
        self.socket.writeString("vote:" + (mybtn.titleLabel?.text)!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
