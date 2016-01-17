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

class AccessoryControlViewController : UIViewController, UITableViewDataSource, HMAccessoryDelegate {
    
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
        //currentCharacteristics = [HMCharacteristic] ()
        
        currentServices = currentAccessory!.services
        
        //remove the first service as it is not required.
        currentServices?.removeFirst()
        
        //enable notifications on all characteristics
        enableNotificationForCharacteristics()
        
        
        //assign accessory's delegate so that we can receive updates on characteristics changing
        currentAccessory?.delegate = self
        
        //
      
    }
    
    func enableNotificationForCharacteristics()
    {
        for service in  currentServices!
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
        
        //get characteristic type
        let characteristicType = currentServices![indexPath.section].characteristics[indexPath.row+1].characteristicType
        
        let cell = getCell(characteristicType, characteristic: currentServices![indexPath.section].characteristics[indexPath.row+1])
        
        return cell

    }
    
    //read current value of the characteristic and assign to control inside cell
    func readCurrentValue (var cell : UITableViewCell, characteristic : HMCharacteristic, typeOfValue : Int)
    {
        characteristic.readValueWithCompletionHandler { (error: NSError?) -> Void in
            if(error != nil)
            {
                return
            }
            switch(typeOfValue)
            {
                case 0:
                    let temporaryCell = cell as! BooleanCell
                    temporaryCell.onOffSwitch.on = characteristic.value as! Bool
                    cell = temporaryCell
                    break;
                case 1:
                    let temporaryCell = cell as! NumericCell
                    temporaryCell.slider.minimumValue = characteristic.metadata!.minimumValue! as Float
                    temporaryCell.slider.maximumValue = characteristic.metadata!.maximumValue! as Float
                    temporaryCell.slider.value = characteristic.value! as! Float
          
                    cell = temporaryCell
                    break;
                case 2:
                    let temporaryCell = cell as! FanDirectionCell
                    if(characteristic.value as! Int == HMCharacteristicValueRotationDirection.Clockwise.rawValue)
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 0;
                    }
                    else
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 1;
                    }
                    cell = temporaryCell
                    break;
                case 3:
                    let temporaryCell = cell as! DoorStateCell
                    if(characteristic.value as! Int == HMCharacteristicValueDoorState.Open.rawValue)
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 0;
                    }
                    else if (characteristic.value as! Int == HMCharacteristicValueDoorState.Closed.rawValue)
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 1;
                    }
                    else if (characteristic.value as! Int == HMCharacteristicValueDoorState.Opening.rawValue)
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 2;
                    }
                    else if (characteristic.value as! Int == HMCharacteristicValueDoorState.Closing.rawValue)
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 3;
                    }
                    else
                    {
                        temporaryCell.segmentedControl.selectedSegmentIndex = 4;
                    }
                    cell = temporaryCell
                    break;
                case 4:
                    let temporaryCell = cell as! HeatingCoolingCell
                    if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Off.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 0;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Heat.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 1;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Cool.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 2;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Auto.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 3;
                    }
                    cell = temporaryCell
                    break;
                case 5:
                    let temporaryCell = cell as! LockMechanismStateCell
                    if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Unsecured.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 0;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Secured.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 1;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Jammed.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 2;
                    }
                    else if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Unknown.rawValue)
                    {
                        temporaryCell.segmentControl.selectedSegmentIndex = 3;
                    }
                    break;
                default:
                    break;
            }
        }
        
    }
    
    
    
    func getCell(characteristicType:String, characteristic: HMCharacteristic) -> UITableViewCell {
        
        if(booleanCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("booleanvalue") as! BooleanCell
            //assign characteristic to cell
            cell.characteristic = characteristic
            //set name of characteristic from dictionary
            cell.label.text = booleanCharacteristics[characteristicType]
            
            //read current value of characteristic
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 0)
        
            //disable control if user is not allowed to write a value to the characteristic
            disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 0)
            return cell
        }
        else if (numericalCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("numericvalue") as! NumericCell
            cell.characteristic = characteristic
            cell.label.text = numericalCharacteristics[characteristicType]
            
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 1)
            
            disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 1)
            return cell

        }
        else if (fanCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("fandirection") as! FanDirectionCell
            cell.characteristic = characteristic
            cell.label.text = fanCharacteristics[characteristicType]
            
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 2)
            
            //disable control if you cannot write to property
            disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 2)
            return cell

        }
        else if (doorCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("doorstate") as! DoorStateCell
            cell.label.text = doorCharacteristics[characteristicType]
            
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 3)
            disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 3)
            
            return cell

        }
        else if (heatingCoolingCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("heatingcooling") as! HeatingCoolingCell
            cell.label.text = heatingCoolingCharacteristics[characteristicType]
            cell.characteristic = characteristic
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 4)
             disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 4)
            return cell
        }
        else if (lockMechanismCharacteristics[characteristicType] != nil)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("lockmechanism") as! LockMechanismStateCell
            cell.label.text = lockMechanismCharacteristics[characteristicType]
            cell.characteristic = characteristic
            readCurrentValue(cell as UITableViewCell, characteristic: characteristic, typeOfValue: 5)
            disableCellIfNecessary(cell, characteristic: characteristic, typeOfValue: 5)
            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")!
            return cell
        }
        
    }
    
    func disableCellIfNecessary(var cell : UITableViewCell, characteristic : HMCharacteristic, typeOfValue : Int)
    {
        if(characteristic.properties.contains(HMCharacteristicPropertyWritable) == false)
        {
            switch(typeOfValue)
            {
            case 0:
                let temporaryCell = cell as! BooleanCell
                temporaryCell.onOffSwitch.enabled = false
                cell = temporaryCell
                break
            case 1:
                let temporaryCell = cell as! NumericCell
                temporaryCell.slider.enabled = false
                cell = temporaryCell
                break
            case 2:
                let temporaryCell = cell as! FanDirectionCell
                temporaryCell.segmentedControl.enabled = false
                cell = temporaryCell
                break
            case 3:
                let temporaryCell = cell as! DoorStateCell
                temporaryCell.segmentedControl.enabled = false
                cell = temporaryCell
                break
            case 4:
                let temporaryCell = cell as! HeatingCoolingCell
                temporaryCell.segmentControl.enabled = false
                cell = temporaryCell
                break
            case 5:
                let temporaryCell = cell as! LockMechanismStateCell
                temporaryCell.segmentControl.enabled = false
                cell = temporaryCell
                break
            default:
                break
            }
            
        }
    }
    
    func accessory(accessory: HMAccessory, service: HMService, didUpdateValueForCharacteristic characteristic: HMCharacteristic) {
        
        if(accessory == currentAccessory && currentServices!.contains(service))
        {
            for s in currentServices!
            {
                if(s == service)
                {
                    for var c in s.characteristics
                    {
                        if(c == characteristic)
                        {
                            //update value
                            c = characteristic
                            tableView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        for s in currentServices!
        {
            for c in s.characteristics
            {
                c.enableNotification(false, completionHandler: { (error: NSError?) -> Void in
                    
                })
            }
        }
    }
}
