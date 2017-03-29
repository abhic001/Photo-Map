//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {
    
    let ivc = UIImagePickerController()

    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var theImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
        ivc.delegate = self
        ivc.allowsEditing = true
        mapView.delegate = self
        
        uploadPhotoButton.layer.cornerRadius = uploadPhotoButton.frame.width/2;
    }
    func showImagePickerController() {
        self.presentViewController(ivc, animated: true, completion: nil)
    }
    @IBAction func onUpload(sender: AnyObject) {
        ivc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        showImagePickerController()
    }

    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber){
        let locationCoordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)
        
        self.navigationController?.popToViewController(self, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "\(latitude), \(longitude)"
        mapView.addAnnotation(annotation)
        
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView!.canShowCallout = true
            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
        }
        
        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
        imageView.image = theImage
        
        return annotationView
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        theImage = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: {
            self.performSegueWithIdentifier("tagSegue", sender: self)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let locations = segue.destinationViewController as? LocationsViewController {
            locations.delegate = self
            locations.userInfo = self
        }
    }
}
