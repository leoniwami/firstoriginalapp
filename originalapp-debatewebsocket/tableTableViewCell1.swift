//
//  tableTableViewCell1.swift
//  originalapp-debatewebsocket
//
//  Created by Leon Iwami on 2016/02/16.
//  Copyright © 2016年 Leon Iwami. All rights reserved.
//

import UIKit

class tableTableViewCell1: UITableViewCell {
    
    @IBOutlet var face: UIImageView!
    @IBOutlet var textmessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(texts:String, atIndexPath indexPath: NSIndexPath){
        print(texts)
        textmessage!.text = texts
        
    }
    
}
