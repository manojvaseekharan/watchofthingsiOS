//
//  RoomsViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 10/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class RoomsViewController : UIViewController, HMHomeManagerDelegate, UITableViewDataSource, UITableViewDelegate, HMHomeDelegate {
    
    //passed from previous view
    var homeManager : HMHomeManager?
    var currentHome : HMHome?
    var currentRooms : [HMRoom]?
    
    @IBOutlet weak var addNewRoom: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let action : Selector = Selector("createAlert")
        addNewRoom.target = self
        addNewRoom.action = action
        homeManager?.delegate = self
        
    }
    
    func home(home: HMHome, didAddRoom room: HMRoom) {
        //room was added
        currentRooms = home.rooms
        tableView.reloadData()
    }
    
    
    func createAlert()
    {
        let cancel = UIAlertAction(title: "Return", style: UIAlertActionStyle.Default, handler: nil)
        let alert = UIAlertController(title: "New Room", message: "Enter the name of your room", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField : UITextField) -> Void in
            //nothing to do here
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            self.currentHome?.addRoomWithName(alert.textFields![0].text!, completionHandler: { (room : HMRoom?, error : NSError?) -> Void in
                if(error != nil)
                {
                    let errorAlert : UIAlertController = UIAlertController(title: "Error", message: "Could not add room. Please try again with a different name.", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(cancel)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
                else
                {
                    self.currentRooms?.append(room!)
                    self.tableView.reloadData()
                }
            })
         
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
            //do nothing
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(currentHome != nil && currentHome?.rooms.count == 0)
        {
            print("error")
            let cell = tableView.dequeueReusableCellWithIdentifier("errorcell")
            return cell!
        }
        else
        {
            print("no error")
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")
            cell!.textLabel!.text = currentRooms![indexPath.row].name
            return cell!
        }
        
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentRooms == nil)
        {
            //if HomeManager has not returned results from the HomeKit DB, then set 0.
            return 0;
        }
        if (currentRooms != nil && currentRooms?.count == 0)
        {
            print("returned")
            //if HomeManager has returned results from HomeKit DB and there are no Rooms set, return single row for error message.
            return 1;
        }
        else
        {
            //return number of Rooms
            return (currentRooms?.count)!
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
