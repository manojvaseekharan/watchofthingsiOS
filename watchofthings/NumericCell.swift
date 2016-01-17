//
//  NumericCell.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 16/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class NumericCell : UITableViewCell {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    var characteristic : HMCharacteristic?
    
    
   
    @IBAction func valueChanged(sender: UISlider) {
        let newValue = round(sender.value)
        characteristic!.writeValue(newValue, completionHandler: { (error: NSError?) -> Void in
            if(error != nil)
            {
                print("Error writing value to \(self.characteristic)")
                print(error)
            }
            
        })
    }
}

