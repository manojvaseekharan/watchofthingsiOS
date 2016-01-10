//
//  AccessoriesViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 09/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import UIKit
import HomeKit

class AccessoriesViewController: UIViewController, HMHomeManagerDelegate {
    
    //Add or remove accessories from a home
    
    var homeManager : HMHomeManager?
    let configureHomeTitle = "No Homes Configured"
    let configureHomeMessage = "In order to manage accessories, you must first configure a home.\nPlease return to the main menu and select 'Manage Home' to add a new Home to your Apple ID."
    let configureRoomTitle = "No Rooms Configured"
    let configureRoomMessage = "In order to manage accessories, you must first create a room for your home(s).\nPlease return to the main menu and select 'Manage Home' to add a new Room to your desired Home."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeManager = HMHomeManager()
        homeManager?.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        //no homes?
        if(manager.homes.count == 0)
        {
            let alert = UIAlertController(title: configureHomeTitle, message: configureHomeMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(createReturnToMenuUIAlertAction())
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        var atLeastOneRoomExists : Bool = false
        for home in manager.homes
        {
            if(home.rooms.count > 0)
            {
                atLeastOneRoomExists = true
            }
        }
        //no rooms?
        if(atLeastOneRoomExists == false)
        {
            
            let alert = UIAlertController(title: configureRoomTitle, message: configureRoomMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(createReturnToMenuUIAlertAction())
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        else
        {
            //populateTable
        }
        
    }
    
    func createReturnToMenuUIAlertAction() -> UIAlertAction
    {
        return UIAlertAction(title: "Back to Menu", style: UIAlertActionStyle.Cancel, handler: {(UIAlertAction) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    
    
    
    
    


}
