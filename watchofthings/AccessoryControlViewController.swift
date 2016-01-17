//
//  AccessoryControlViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 14/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class AccessoryControlViewController : UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //passed from previous view
    var homeManager : HMHomeManager?
    var currentHome : HMHome?
    var currentRoom : HMRoom?
    var currentAccessory : HMAccessory?
    var currentServices : [HMService]?
    var currentCharacteristics : [HMCharacteristic]?
    
    
    let booleanCharacteristics = [HMCharacteristicTypePowerState : "Power State", HMCharacteristicTypeObstructionDetected : "Obstruction", HMCharacteristicTypeOutletInUse : "Outlet In Use", HMCharacteristicTypeMotionDetected : "Motion Detected"]
    
    let numericalCharacteristics = [HMCharacteristicTypeHue : "Hue", HMCharacteristicTypeSaturation : "Saturation", HMCharacteristicTypeBrightness : "Brightness", HMCharacteristicTypeCurrentTemperature : "Current Temperature", HMCharacteristicTypeTargetTemperature : "Target Temperature", HMCharacteristicTypeCoolingThreshold : "Cooling Threshold", HMCharacteristicTypeHeatingThreshold : "Heating Threshold", HMCharacteristicTypeCurrentRelativeHumidity : "Current Relative Humidity", HMCharacteristicTypeTargetRelativeHumidity : "Target Relative Humidity", HMCharacteristicTypeRotationSpeed : "Rotation Speed", HMCharacteristicTypeLockManagementAutoSecureTimeout : "Lock's Timeout Period"]
    
    let heatingCoolingCharacteristics = [HMCharacteristicTypeCurrentHeatingCooling : "Current Heating/Cooling Mode", HMCharacteristicTypeTargetHeatingCooling : "Target Heating/Cooling Mode"]
    
    let lockMechanismCharacteristics = [HMCharacteristicTypeCurrentLockMechanismState : "Current Lock State", HMCharacteristicTypeTargetLockMechanismState : "Target Lock State"]
    
    let doorCharacteristics = [HMCharacteristicTypeCurrentDoorState as String : "Current Door State", HMCharacteristicTypeTargetDoorState as String : "Target Door State"]
    
    let fanCharacteristics = [HMCharacteristicTypeRotationDirection : "Rotation Direction"]
    
    let temperatureUnitCharacteristics = [HMCharacteristicTypeTemperatureUnits : "Temperature Units"]
    
    //hold all of the above in an array of dictionaries
    var characteristics = [[String : String]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacteristics()
        
        //initialise array of characteristics
        currentCharacteristics = [HMCharacteristic] ()
        
        currentServices = currentAccessory!.services
        
        //remove the first service as it is not required.
        currentServices?.removeFirst()
        
        //append characteristics into currentCharacteristics array (NOTE: we may not need this...)
        for service in currentServices!
        {
            currentCharacteristics?.appendContentsOf(service.characteristics)
        }
        
    }
    
    func setupCharacteristics()
    {
        characteristics.append(booleanCharacteristics)
        characteristics.append(numericalCharacteristics)
        characteristics.append(heatingCoolingCharacteristics)
        characteristics.append(lockMechanismCharacteristics)
        characteristics.append(doorCharacteristics)
        characteristics.append(fanCharacteristics)
        characteristics.append(temperatureUnitCharacteristics)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //disregard 'type name' characteristic, so - 1 from the count
        return currentServices![section].characteristics.count - 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //first service is discarded in the viewDidLoad method
        return currentServices!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentServices![section].name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if(currentServices!.count == 0)
//        {
//            //return cell saying no services defined.
//            return nil
//        }
//        else
//        {
            //let serviceName = currentServices![indexPath.section].name
        
            let characteristic = currentServices![indexPath.section].characteristics[indexPath.row+1].characteristicType
            let cell = tableView.dequeueReusableCellWithIdentifier("booleanvalue") as! BooleanCell
            for characteristictype in characteristics
            {
                
                if(characteristictype[characteristic] != nil)
                {
                    cell.label.text = characteristictype[characteristic]
                    cell.onoffSwitch.on = true
                }
            }
            return cell
//        }
    }
    
    
    
    
    
    
    
}
