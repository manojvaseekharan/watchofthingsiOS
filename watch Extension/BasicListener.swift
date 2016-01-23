//
//  BasicListener.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class BasicListener :  NSObject, HMAccessoryDelegate, Listener {
    
    
    
    //set up phase - enable notification for each characteristic change
    func configure(homeManager: HMHomeManager) {
        for home in homeManager.homes
        {
            for room in home.rooms
            {
                for accessory in room.accessories
                {
                    if(accessory.reachable)
                    {
                        accessory.delegate = self
                        for service in accessory.services
                        {
                            
                            for characteristic in service.characteristics
                            {
                                
                                //always skip the first characteristic
                                if(characteristic == service.characteristics[0])
                                {
                                    continue
                                }
                                if(characteristic.properties.contains(HMCharacteristicPropertySupportsEventNotification))
                                {
                                    print("\(characteristic) supports event notification")
                                    characteristic.enableNotification(true, completionHandler: { (error:NSError?) -> Void in
                                        if(error != nil)
                                        {
                                            print(error)
                                        }
                                    })
                                }
                                
                                
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic) {
        print("Accessory: \(accessory), Service: \(service), Characteristic: \(characteristic)")
    }
    
    func deconfigure(homeManager: HMHomeManager) {
        for home in homeManager.homes
        {
            for room in home.rooms
            {
                for accessory in room.accessories
                {
                    if(accessory.reachable)
                    {
                        for service in accessory.services
                        {
                            
                            for characteristic in service.characteristics
                            {
                                
                                //always skip the first characteristic
                                if(characteristic == service.characteristics[0])
                                {
                                    continue
                                }
                                if(characteristic.properties.contains(HMCharacteristicPropertySupportsEventNotification))
                                {
                                    print("\(characteristic) turned off")
                                    characteristic.enableNotification(false, completionHandler: { (error:NSError?) -> Void in
                                        if(error != nil)
                                        {
                                            print(error)
                                        }
                                    })
                                }
                                
                                
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
}
