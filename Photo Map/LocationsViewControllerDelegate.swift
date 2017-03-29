//
//  LocationsViewControllerDelegate.swift
//  Photo Map
//
//  Created by Abhijeet Chkarbaarti on 3/28/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

// Protocol definition - top of LocationsViewController.swift
protocol LocationsViewControllerDelegate : class {
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber)
}
