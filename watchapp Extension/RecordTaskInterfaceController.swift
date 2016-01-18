//
//  RecordTaskInterfaceController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 18/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import WatchKit
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class RecordTaskInterfaceController: WKInterfaceController, HMHomeManagerDelegate, HMAccessoryDelegate{
    
    var homeManager : HMHomeManager?
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        homeManager = HMHomeManager()
        homeManager!.delegate = self
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        //update homeManager reference
        homeManager = manager
        
        //activate listener for all accessories
        for home in manager.homes
        {
            for rooms in home.rooms
            {
                for accessory in rooms.accessories
                {
                    //set this class to act as delegate
                    accessory.delegate = self
                    for service in accessory.services
                    {
                        for characteristic in service.characteristics
                        {
                            if(characteristic.properties.contains(HMCharacteristicPropertySupportsEventNotification))
                            {
                                characteristic.enableNotification(true, completionHandler: { (error: NSError?) -> Void in
                                    if(error != nil)
                                    {
                                        print("Error enabling notification on characteristic: \(characteristic.characteristicType)")
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
        
      
    }
    
    func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic) {
        
        print("Accessory = \(accessory), Service = \(service), Characteristic new value = \(characteristic)")
        
    }
    
}

