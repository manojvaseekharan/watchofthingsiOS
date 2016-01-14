//
//  RoomsAccessoriesViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 10/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class RoomsAccessoriesViewController : UIViewController, HMHomeManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    
   
    //passed from previous view
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewAccessory: UIBarButtonItem!
    var homeManager : HMHomeManager?
    var currentHome : HMHome?
    var currentRoom : HMRoom?
    var currentAccessories : [HMAccessory]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeManager?.delegate = self
        self.navigationItem.title = currentRoom?.name
        tableView.allowsMultipleSelectionDuringEditing = false
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "addNewAccessory")
        {
            let findAccessoriesVC : FindAccessoryViewController = segue.destinationViewController as! FindAccessoryViewController
            
            findAccessoriesVC.homeManager = self.homeManager
            findAccessoriesVC.currentHome = self.currentHome
            findAccessoriesVC.currentRoom = self.currentRoom
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(currentRoom?.accessories != nil && currentRoom?.accessories.count == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("errorcell")
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")
            cell!.textLabel!.text = currentRoom?.accessories[indexPath.row].name
            return cell!
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentRoom?.accessories == nil)
        {
            return 0;
        }
        if (currentRoom?.accessories != nil && currentRoom!.accessories.count == 0)
        {

            return 1;
        }
        else
        {
            //return number of Accessories
            return (currentRoom?.accessories.count)!
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            //display prompt asking user if they want to delete a home.
            let alert = UIAlertController(title: "Delete Accessory", message: "Are you sure you want to delete \(currentRoom!.accessories[indexPath.row].name) from \(currentRoom!.name)?\n", preferredStyle: UIAlertControllerStyle.Alert)
            //delete from table view, delete
            
            let confirm = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
                self.currentHome?.removeAccessory(self.currentRoom!.accessories[indexPath.row], completionHandler: { (error: NSError?) -> Void in
                    tableView.reloadData()
                })
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
                //do nothing
            })
            
            alert.addAction(cancel)
            alert.addAction(confirm)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}
