//
//  BooleanCell.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 17/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class BooleanCell : UITableViewCell{
    
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    @IBOutlet weak var label: UILabel!
    
    var characteristic : HMCharacteristic?
    
    @IBAction func valueChanged(sender: UISwitch) {
        
        if(sender.on)
        {
            characteristic?.writeValue(true, completionHandler: { (error: NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                }
            })
        }
        else
        {
            characteristic?.writeValue(false, completionHandler: { (error: NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                }
            })
        }
        
    }
}
