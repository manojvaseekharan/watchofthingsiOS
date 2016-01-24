//
//  BasicInstructionStore.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 24/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class BasicInstructionStore : InstructionStore {
    
    var listOfInstructions : [(HMAccessory, HMService, HMCharacteristic, AnyObject)] = []
    
    func storeInstruction(accessory: HMAccessory, service: HMService, characteristic: HMCharacteristic) {
        let instruction = (accessory, service, characteristic, characteristic.value! as AnyObject)
        listOfInstructions.append(instruction)
    }
}
