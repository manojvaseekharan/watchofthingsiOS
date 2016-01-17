//
//  FanDirectionCell.swift
//  watchofthings
//
//  Created by Manoj Vaseekharan on 16/01/2016.
//  Copyright © 2016 Manoj Vaseekharan. All rights reserved.
//

import Foundation
import UIKit
import HomeKit

class FanDirectionCell : UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var characteristic : HMCharacteristic?
}
