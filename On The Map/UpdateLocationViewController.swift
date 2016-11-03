//
//  UpdateLocationViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 01/11/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit
import MapKit

class UpdateLocationViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate {
    
    
    var currentState = 0
    let oParseClient = ParseClient()
    let geoCoder = CLGeocoder()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var topView: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    func setupUI(){
        switch currentState {
        case 0:
            mapView.isHidden = true
            topView.backgroundColor = UIColor.cyan
            label.text = "Where can we follow you?"
            textField.placeholder = "Enter your Media URL"
            button.setTitle("Continue", for: .normal)
            currentState = 1
           break
        case 1:
            LocationDetails.mediaUrl = textField.text!
            textField.text = ""
            topView.backgroundColor = UIColor.brown
            label.text = "Where are you from?"
            textField.placeholder = "City, Country"
            button.setTitle("Find On Map", for: .normal)
            currentState = 2
            break
        case 2:
            mapView.isHidden = false
            LocationDetails.locationString = textField.text!
            label.isHidden = true
            textField.isHidden = true
            button.setTitle("Update", for: .normal)
            mapView.bringSubview(toFront: bottomView)
            fetchAndDisplayLocation(location: textField.text!)
            currentState = 3
            break
        case 3:
            oParseClient.updateStudentsData(){ result, success,error in
                if success {
                    performUIUpdatesOnMain {
                        self.performSegue(withIdentifier: "backToMap", sender: self)
                    }
                }
            }
            break
        default:
            break
        }
    }
    
    @IBAction func cancelledClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonClicked(_ sender: AnyObject) {
        setupUI()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func fetchAndDisplayLocation(location: String){
        geoCoder.geocodeAddressString(location){ placemark, error  in
            let latDelta:CLLocationDegrees = 0.01
            let longDelta:CLLocationDegrees = 0.01
            let lat = placemark?[0].location?.coordinate.latitude
            let long = placemark?[0].location?.coordinate.longitude
            
            guard lat != nil else{
                return
            }
            
            guard long != nil else {
                return
            }
            
            LocationDetails.latitude = lat
            LocationDetails.longitude = long

            
            let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)

            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(pointLocation, theSpan)
            self.mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location
            annotation.subtitle = LocationDetails.mediaUrl
            self.mapView.addAnnotation(annotation)
        }
    }
}
