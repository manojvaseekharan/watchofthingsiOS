//
//  Listener.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit

@available(watchOSApplicationExtension 20000, *)
protocol Listener : HMAccessoryDelegate {
    
    func configure(homeManager:HMHomeManager)
    
    func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic)
    
    func deconfigure(homeManager : HMHomeManager)
    
    
}
