//
//  LockMechanismStateCell.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 16/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class LockMechanismStateCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var characteristic : HMCharacteristic?
    
    
    @IBAction func valueChanged(sender: UISegmentedControl) {
        let newValue = sender.selectedSegmentIndex
        switch(newValue)
        {
        case 0:
            characteristic?.writeValue(HMCharacteristicValueLockMechanismState.Unsecured.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 1:
            characteristic?.writeValue(HMCharacteristicValueLockMechanismState.Secured.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 2:
            characteristic?.writeValue(HMCharacteristicValueLockMechanismState.Jammed.rawValue, completionHandler: { (error : NSError?) -> Void in
                if(error != nil)
                {
                    print("Error writing value to \(self.characteristic)")
                    print(error)
                }
            })
            break
        case 3:
            characteristic?.writeValue(HMCharacteristicValueLockMechanismState.Unknown.rawValue, completionHandler: { (error : NSError?) -> Void in
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
