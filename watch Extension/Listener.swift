//
//  Listener.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit
import WatchKit

@available(watchOSApplicationExtension 20000, *)

protocol Listener : HMAccessoryDelegate {
    
    var instructionStore : InstructionStore
        {
        get set
        }
    
    init(table: WKInterfaceTable, instructionStore : InstructionStore)
    
    func configure(homeManager:HMHomeManager)
    
    func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic)
    
    func deconfigure(homeManager : HMHomeManager)
    
    
    
}
