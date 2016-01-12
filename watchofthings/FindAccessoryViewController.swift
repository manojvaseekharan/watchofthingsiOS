//
//  FindAccessoryViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 12/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class FindAccessoryViewController : UIViewController, HMHomeManagerDelegate, HMAccessoryBrowserDelegate, UITableViewDataSource, UITableViewDelegate, HMAccessoryDelegate {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var homeManager : HMHomeManager?
    var currentHome : HMHome?
    var currentRoom : HMRoom?
    var foundAccessories : [HMAccessory]?
    
    var homeAccessoryBrowser : HMAccessoryBrowser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foundAccessories = [HMAccessory]()
        homeAccessoryBrowser = HMAccessoryBrowser()
        homeAccessoryBrowser?.delegate = self
        homeAccessoryBrowser?.startSearchingForNewAccessories()
        backButton.action = "backToRooms"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func backToRooms()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Found an accessory!
    func accessoryBrowser(browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        
        foundAccessories = browser.discoveredAccessories
        tableView.reloadData()
        
        
    }
    
    func accessoryBrowser(browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        foundAccessories = browser.discoveredAccessories
        tableView.reloadData()
    }
    
    //before leaving view, stop searching for accessories
    override func viewWillDisappear(animated: Bool) {
        homeAccessoryBrowser?.stopSearchingForNewAccessories()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(foundAccessories == nil)
        {
            return 0
        }
        else if (foundAccessories!.count == 0)
        {
            //return loading cell
            return 1
        }
        else
        {
            // the + 1 is here because we want to show the loading cell after all of the devices
            return foundAccessories!.count + 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(foundAccessories == nil || foundAccessories!.count == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("loadingcell")
            return cell!
        }
        else if (indexPath.row < foundAccessories!.count)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")
            //allow multiple lines
            //cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.text = foundAccessories![indexPath.row].name
            return cell!
        }
            //loading cell always appears at bottom of screen
            let cell = tableView.dequeueReusableCellWithIdentifier("loadingcell")
            return cell!
        
    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row == foundAccessories!.count)
        {
            return
        }
        
        let accessoryToAdd = foundAccessories![indexPath.row]
        //display alert asking user if they are sure about adding the accessory to the room
        let alert = UIAlertController(title: "Add New Accessory", message: "Are you sure you want to add \(foundAccessories![indexPath.row].name) to \(currentRoom!.name)?", preferredStyle: UIAlertControllerStyle.Alert)
        
        //confirm action
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            //add to home
            self.currentHome?.addAccessory(accessoryToAdd, completionHandler: { (error : NSError?) -> Void in
                //nothing
                if(error != nil)
                {
//                    //add 
                }
                else
                {
                    //ok it's added to home, now add it to
                    self.currentHome?.assignAccessory(accessoryToAdd, toRoom: self.currentRoom!, completionHandler: { (error:NSError?) -> Void in
                        if(error != nil)
                        {
                            print("error")
                            print(error)
                        }
                        //nothing
                    })

                }
            })
            //assign to room
                        //then once alert disappears, move back to previous screen.
            //self.backToRooms()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            //do nothing
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
    
    
    
    

