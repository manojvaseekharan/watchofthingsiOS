//
//  DoorStateCell.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 16/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class DoorStateCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var characteristic : HMCharacteristic?
    
    
    @IBAction func valueChanged(sender: UISegmentedControl) {
        let newValue = sender.selectedSegmentIndex
        switch(newValue)
        {
        case 0:
            characteristic?.writeValue(HMCharacteristicValueDoorState.Open.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 1:
            characteristic?.writeValue(HMCharacteristicValueDoorState.Closed.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 2:
            characteristic?.writeValue(HMCharacteristicValueDoorState.Opening.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 3:
            characteristic?.writeValue(HMCharacteristicValueDoorState.Closed.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 4:
            characteristic?.writeValue(HMCharacteristicValueDoorState.Stopped.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        default:
            break
        }
        
        
    }
    
    
}

