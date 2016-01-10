	//
//  ViewController.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 07/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import UIKit
import HomeKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    //segue into new view
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row)
        {
            case 0:
                print("New Task")
                break
            case 1:
                print("Manage Accessories")
                break
            case 2:
                print("Manage Home")
                break
            case 3:
                print("Manage Tasks")
                break
            default:
                print("ERROR")
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    //create cells
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        switch(indexPath.row)
        {
        case 0:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("newTask", forIndexPath: indexPath)
            break
        case 1:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("manageAccessories", forIndexPath: indexPath)
            break
        case 2:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("manageHome", forIndexPath: indexPath)
            break
        case 3:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier("manageTasks", forIndexPath: indexPath)
            break
        default:
            break
        }
        return cell!
    }
    
    //linespacing
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
         return (collectionView.frame.size.width)/14
    }
    
    //size of cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let sizeOfCell = ((collectionView.frame.width * 3) / 4) - (((collectionView.frame.size.width)/10) * 2)
        return CGSize(width: sizeOfCell, height: sizeOfCell)
    }
    
    //padding for section
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let padding = (collectionView.frame.size.width)/14
        return UIEdgeInsets(top: CGFloat(padding), left: CGFloat(padding), bottom: CGFloat(padding), right: CGFloat(padding))
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


