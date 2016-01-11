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
        //let action : Selector = Selector("createAlert")
        //addNewAccessory.target = self
        //addNewAccessory.action = action
        homeManager?.delegate = self
        self.navigationItem.title = currentRoom?.name
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "addNewAccessory")
        {
            //TODO: new view for adding accessory to room of home
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(currentAccessories != nil && currentAccessories?.count == 0)
        {
            print("error cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("errorcell")
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardcell")
            cell!.textLabel!.text = currentAccessories![indexPath.row].name
            return cell!
        }
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(currentAccessories == nil)
        {
            return 0;
        }
        if (currentAccessories != nil && currentAccessories?.count == 0)
        {

            return 1;
        }
        else
        {
            //return number of Accessories
            return (currentAccessories?.count)!
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
