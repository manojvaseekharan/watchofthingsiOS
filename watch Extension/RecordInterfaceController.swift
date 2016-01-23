//
//  RecordInterfaceController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import WatchKit
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class RecordInterfaceController : WKInterfaceController, HMHomeManagerDelegate{
    
    var homeManager : HMHomeManager?
    
    @IBOutlet var doneButton: WKInterfaceButton!
  
    @IBOutlet var errorCellGroup: WKInterfaceGroup!
 
    @IBOutlet var table: WKInterfaceTable!
    
    var listener : Listener?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        self.setTitle("Record Task")
        homeManager = HMHomeManager()
        homeManager!.delegate = self
        super.willActivate()
    }
    
    
    
    @IBAction func buttonPressed() {
        listener?.deconfigure(self.homeManager!)
        self.dismissController()
    }
    
    override func didAppear() {
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //when first assigning delegate, or when home is added, this method is called.
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        self.homeManager = manager
        var errorString : String?
        switch(checkIfRecordingCanStart())
        {
            case 0:
                //successful
                configureListener()
                return
            case 1:
                errorString = "No Homes Configured! Add a home through the watchofthings iOS app."
            case 2:
                errorString = "No Rooms Configured! Add a room to a home through the watchofthings iOS app."
            case 3:
                errorString = "No Accessories are reachable! Make sure they are connected to your network and try again."
            default:
                errorString = "Unexpected Error!"
        }
        
        table.setNumberOfRows(1, withRowType: "errorRow")
        let myRowController = table.rowControllerAtIndex(0) as! RowType
        myRowController.label.setText(errorString)
        
        //check if home has rooms/accessories
    }
    
    //check whether recording can start
    func checkIfRecordingCanStart() -> Int
    {
        if(self.homeManager?.homes.count == 0)
        {
            return 1
        }
        else
        {
            var roomsExist = false
            for home in (self.homeManager?.homes)!
            {
                if(home.rooms.count != 0)
                {
                    roomsExist = true
                }
            }
            if(roomsExist == false)
            {
                return 2
            }
        }
        for home in (self.homeManager?.homes)!
        {
            for room in home.rooms
            {
                for accessory in room.accessories
                {
                    if(accessory.reachable == true)
                    {
                        return 0
                    }
                }
            }
        }
        return 3
    }
    
    //Prepares to listen for state changes in accessories
    func configureListener()
    {
        //need to swap out listener implementation as we iterate through designs
        self.listener = BasicListener()
        listener!.configure(self.homeManager!)
    }

}
