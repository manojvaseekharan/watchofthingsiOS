//
//  InstructionStore.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 24/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit

@available(watchOSApplicationExtension 20000, *)
protocol InstructionStore {
    
    var listOfInstructions : [(HMAccessory, HMService, HMCharacteristic, AnyObject)] {
        get set
    }
    
    func storeInstruction(accessory: HMAccessory, service: HMService, characteristic: HMCharacteristic)
    
    
}
