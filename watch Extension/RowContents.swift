//
//  RowContents.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 23/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import HomeKit

@available(watchOSApplicationExtension 20000, *)
class RowContents
{
    static let booleanCharacteristics = [HMCharacteristicTypePowerState : "Power State", HMCharacteristicTypeObstructionDetected : "Obstruction", HMCharacteristicTypeOutletInUse : "Outlet In Use", HMCharacteristicTypeMotionDetected : "Motion Detected"]
    
    static let numericalCharacteristics = [HMCharacteristicTypeHue : "Hue", HMCharacteristicTypeSaturation : "Saturation", HMCharacteristicTypeBrightness : "Brightness", HMCharacteristicTypeCurrentTemperature : "Current Temperature", HMCharacteristicTypeTargetTemperature : "Target Temperature", HMCharacteristicTypeCoolingThreshold : "Cooling Threshold", HMCharacteristicTypeHeatingThreshold : "Heating Threshold", HMCharacteristicTypeCurrentRelativeHumidity : "Current Relative Humidity", HMCharacteristicTypeTargetRelativeHumidity : "Target Relative Humidity", HMCharacteristicTypeRotationSpeed : "Rotation Speed", HMCharacteristicTypeLockManagementAutoSecureTimeout : "Lock's Timeout Period"]
    
    static let heatingCoolingCharacteristics = [HMCharacteristicTypeCurrentHeatingCooling : "Current Heating/Cooling Mode", HMCharacteristicTypeTargetHeatingCooling : "Target Heating/Cooling Mode"]
    
    static let lockMechanismCharacteristics = [HMCharacteristicTypeCurrentLockMechanismState : "Current Lock State", HMCharacteristicTypeTargetLockMechanismState : "Target Lock State"]
    
    static let doorCharacteristics = [HMCharacteristicTypeCurrentDoorState as String : "Current Door State", HMCharacteristicTypeTargetDoorState as String : "Target Door State"]
    
    static let fanCharacteristics = [HMCharacteristicTypeRotationDirection : "Rotation Direction"]
    
    static let temperatureUnitCharacteristics = [HMCharacteristicTypeTemperatureUnits : "Temperature Units"]
    
    
    static func getRowContentString(accessory: HMAccessory, service: HMService, characteristic: HMCharacteristic) -> String
    {
        if(booleanCharacteristics[characteristic.characteristicType] != nil)
        {
            return getBooleanString(service, characteristic: characteristic)
        }
        else if (numericalCharacteristics[characteristic.characteristicType] != nil)
        {
            return getNumericalString(service, characteristic: characteristic)
        }
        else if (heatingCoolingCharacteristics[characteristic.characteristicType] != nil)
        {
            return getHeatingCooling(service, characteristic :characteristic)
        }
        else if (lockMechanismCharacteristics[characteristic.characteristicType] != nil)
        {
            return getLockMechanism(service, characteristic : characteristic)
        }
        else if (doorCharacteristics[characteristic.characteristicType] != nil)
        {
            return getDoor(service, characteristic : characteristic)
        }
        else if (fanCharacteristics[characteristic.characteristicType] != nil)
        {
            return getFan(service, characteristic : characteristic)
        }
        else if (temperatureUnitCharacteristics[characteristic.characteristicType] != nil)
        {
            return getTemperatureUnit(service, characteristic : characteristic)
        }
        else
        {
            return "not implemented yet!"
        }
    }
    
    static func getTemperatureUnit(service : HMService, characteristic : HMCharacteristic) -> String
    {
        if(characteristic.value as! Int == HMCharacteristicValueTemperatureUnit.Celsius.rawValue)
        {
            return "\(service.name)'s Temperature Unit is now Celcius";
        }
        else if(characteristic.value as! Int == HMCharacteristicValueTemperatureUnit.Fahrenheit.rawValue)
        {
            return "\(service.name)'s Temperature Unit is now Fahrenheit";
        }
        else
        {
            return "error!"
        }
    }
    
    static func getFan(service : HMService, characteristic : HMCharacteristic) -> String
    {
        if(characteristic.value as! Int == HMCharacteristicValueRotationDirection.CounterClockwise.rawValue)
        {
            return "\(service.name)'s rotation direction is now CounterClockwise"
        }
        else if(characteristic.value as! Int == HMCharacteristicValueRotationDirection.Clockwise.rawValue)
        {
            return "\(service.name)'s rotation direction is now Clockwise"
        }
        else
        {
            return "error!"
        }
    }
    
    static func getDoor(service : HMService, characteristic : HMCharacteristic) -> String{
        if(characteristic.value as! Int == HMCharacteristicValueDoorState.Open.rawValue)
        {
            return "Door is Open"
        }
        else if(characteristic.value as! Int == HMCharacteristicValueDoorState.Closed.rawValue)
        {
            return "Door is Closed"
        }
        else if(characteristic.value as! Int == HMCharacteristicValueDoorState.Opening.rawValue)
        {
            return "Door is Opening"
        }
        else if(characteristic.value as! Int == HMCharacteristicValueDoorState.Closing.rawValue)
        {
            return "Door is Closing"
        }
        else if(characteristic.value as! Int == HMCharacteristicValueDoorState.Stopped.rawValue)
        {
            return "Door has been Stopped"
        }
        else
        {
            return "error!"
        }
        
    }
    
    static func getLockMechanism(service : HMService, characteristic : HMCharacteristic) -> String
    {
        
        if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Unsecured.rawValue)
        {
            return "Lock is now Unsecured"
        }
        if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Secured.rawValue)
        {
            return "Lock is now Secured"
        }
        if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Jammed.rawValue)
        {
            return "Lock is now Jammed"
        }
        if(characteristic.value as! Int == HMCharacteristicValueLockMechanismState.Unknown.rawValue)
        {
            return "State of lock is unknown"
        }
        else
        {
            return "error!!"
        }
        
        
    }
    
    static func getHeatingCooling(service : HMService, characteristic : HMCharacteristic) -> String
    {
        
            if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Off.rawValue)
            {
                return "\(service.name) is Switched Off"
            }
            if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Heat.rawValue)
            {
                return "\(service.name) is Set to Heat"
            }
            if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Cool.rawValue)
            {
                return "H\(service.name) is Set to Cool"
            }
            if(characteristic.value as! Int == HMCharacteristicValueHeatingCooling.Auto.rawValue)
            {
                return "\(service.name) is Set to Auto"
            }
            else
            {
                return "error!!"
            }
        
        
    }
    
    static func getBooleanString(service : HMService, characteristic : HMCharacteristic) -> String
    {
        switch(characteristic.characteristicType as String)
        {
        case HMCharacteristicTypePowerState:
            if(characteristic.value as! Bool == true)
            {
                return "Power State has been switched On";
            }
            else
            {
                return "Power State has been switched Off";
            }
        case HMCharacteristicTypeObstructionDetected:
            if(characteristic.value as! Bool == true)
            {
                return "An Obstruction is Present"
            }
            else
            {
                return "An Obstruction is No Longer Present"
            }
        case HMCharacteristicTypeOutletInUse :
            if(characteristic.value as! Bool == true)
            {
                return "Outlet is in Use"
            }
            else
            {
                return "Outlet is No Longer in Use"
            }
        case HMCharacteristicTypeMotionDetected:
            if(characteristic.value as! Bool == true)
            {
                return "Motion is Detected"
            }
            else
            {
                return "Motion is No Longer Detected"
            }
        default:
            return "error!"
        }
    }
    
    static func getNumericalString(service : HMService, characteristic : HMCharacteristic) -> String
    {
        return numericalCharacteristics[characteristic.characteristicType as String]! + "'s value changed to \(characteristic.value as! Float!)"
    }
}
