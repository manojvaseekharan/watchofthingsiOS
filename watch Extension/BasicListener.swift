//
//  BasicListener.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit
import WatchKit

@available(watchOSApplicationExtension 20000, *)
class BasicListener :  NSObject, HMAccessoryDelegate, Listener {
    
    var table : WKInterfaceTable
    
    var instructionStore : InstructionStore
  
    required init(table: WKInterfaceTable, instructionStore : InstructionStore) {
        self.table = table
        self.instructionStore = instructionStore
    }
    
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
                                    print("\(characteristic) turned on!")
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
        //insert new row
        table.insertRowsAtIndexes(NSIndexSet(index: table.numberOfRows), withRowType: "Row")
        //get row controller
        let newRow = table.rowControllerAtIndex(table.numberOfRows-1) as! RowEntry
        //set labels
        newRow.accessoryName.setText("\(accessory.name) in \(accessory.room!.name)")
        newRow.stateChange.setText(RowContents.getRowContentString(accessory, service: service, characteristic: characteristic))
        //scroll down
        table.scrollToRowAtIndex(table.numberOfRows-1)
        
        //store instruction
        self.instructionStore.storeInstruction(accessory, service: service, characteristic: characteristic)
    }
    
  
    
    func deconfigure(homeManager: HMHomeManager) {
        for home in homeManager.homes
        {
            for room in home.rooms
            {
                for accessory in room.accessories
                {
                    accessory.delegate = nil
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
