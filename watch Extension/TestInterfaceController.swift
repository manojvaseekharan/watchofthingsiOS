//
//  TestInterfaceController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 24/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import WatchKit
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class TestInterfaceController : WKInterfaceController {
    
    var instructionStore : InstructionStore?
    var homeManager : HMHomeManager?
    
    override func didAppear() {
        homeManager = HMHomeManager()
    }
    
    @IBAction func testTask() {
        for instruction in (instructionStore?.listOfInstructions)!
        {
            instruction.2.writeValue(instruction.3, completionHandler: { (error :NSError?) -> Void in
            })
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        //passing in the instruction store
        instructionStore = context as? InstructionStore
     
    }

}
