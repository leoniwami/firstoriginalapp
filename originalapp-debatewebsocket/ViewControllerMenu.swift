//
//  ViewControllerMenu.swift
//  originalapp-debatewebsocket
//
//  Created by Leon Iwami on 2016/03/02.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class ViewControllerMenu: UIViewController {
    
    @IBOutlet var question: UITextField!
    @IBOutlet var bluecom: UITextField!
    @IBOutlet var redcom: UITextField!
    @IBOutlet var google: UIButton!
    @IBOutlet var yahoo: UIButton!
    @IBOutlet var twitter: UIButton!
    
    @IBOutlet var saveandsend: UIButton!
    
//    var saveCom: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //url
    @IBAction func googleurl() {
        let url = NSURL(string: "https://www.google.co.jp")
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    @IBAction func yahoourl() {
        let url = NSURL(string: "http://www.yahoo.co.jp/")
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    @IBAction func twitterurl() {
        let url = NSURL(string: "https://twitter.com/")
        if UIApplication.sharedApplication().canOpenURL(url!){
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func savesend(sender: UIButton) {
        performSegueWithIdentifier("segue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segue") {
            let secondView = segue.destinationViewController as! ViewController
            secondView.storymessage = question.text
            secondView.votechoiceblue = bluecom.text
            secondView.votechoicered = redcom.text
        }
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


