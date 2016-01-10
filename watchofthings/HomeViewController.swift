//
//  HomeViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 09/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class HomeViewController : UIViewController, HMHomeManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var addNewHome: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    var homeManager : HMHomeManager?
    var homes : [HMHome]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let action : Selector = Selector("createAlert")
        addNewHome.target = self
        addNewHome.action = action
        homeManager = HMHomeManager()
        homeManager?.delegate = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "homeToRooms")
        {
            print("segue start")
            let path = self.tableView.indexPathForSelectedRow!
            let roomsVC : RoomsViewController = segue.destinationViewController as! RoomsViewController
            roomsVC.homeManager = self.homeManager
            roomsVC.currentHome = homes![path.row]
            roomsVC.currentRooms = homes![path.row].rooms
            
        }
    }
    
    
    
    
    func homeManager(manager: HMHomeManager, didAddHome home: HMHome) {
        homes = manager.homes
        tableView.reloadData()
    }
    
    //triggered when first accessing HomeKit DB or if change was made on another device
    func homeManagerDidUpdateHomes(manager: HMHomeManager) {
        tableView.delegate = self
        tableView.dataSource = self
        //before rendering table view, first see if there are any homes
        homes = manager.homes
        if(manager.homes.count == 0)
        {
            tableView.reloadData()
        }
        else
        {
            tableView.reloadData()
        }
    }
    
    func createAlert()
    {
        let cancel = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default, handler: nil)
        let alert = UIAlertController(title: "New Home", message: "Enter the name of your home", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField : UITextField) -> Void in
            //nothing to do here
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            self.homeManager?.addHomeWithName(alert.textFields![0].text!, completionHandler: { (home: HMHome?, error: NSError?) -> Void in
                if(error != nil)
                {
                    let errorAlert : UIAlertController = UIAlertController(title: "Error", message: "Could not add home. Please try again with a different name.", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(cancel)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
                else
                {
                    self.homes?.append(home!)
                    self.tableView.reloadData()
                    //segue into detail view where rooms can be added
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            //do nothing
        }))
         self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
 
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(homes != nil && homes?.count == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("errorcell")
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")
             cell!.textLabel!.text = homes![indexPath.row].name
            return cell!
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(homes == nil)
        {
            //if HomeManager has not returned results from the HomeKit DB, then set 0.
            return 0;
        }
        if (homes != nil && homes?.count == 0)
        {
            //if HomeManager has returned results from HomeKit DB and there are no Homes set, return single row for error message.
            return 1;
        }
        else
        {
            //return number of Homes
            return (homes?.count)!
        }
        
    }

    
    override func viewWillAppear(animated: Bool) {
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


