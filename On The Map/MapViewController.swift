//
//  MapViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 28/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var studentData = [Students]() {
        didSet {
            DispatchQueue.main.async {
                self.showLocations();
            }
        }
    }
    var annotations = [MKPointAnnotation]()
    var mapView: MKMapView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = MKMapView(frame: view.frame);
        view.addSubview(mapView);
        mapView.delegate = self;
        self.mapView = mapView;
        (parent?.parent as? OnTheMapViewController)?.setupNavigationView(self);
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)! as URL, completionHandler: nil)
            }
        }
    }

    func showLocations() -> Void {
        for dictionary in self.studentData {
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            guard
                let latitude = dictionary.latitude,
                let longitude = dictionary.longitude
                else {continue;}
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let first = dictionary.firstName ?? "";
            let last = dictionary.lastName ?? "";
            
            let mediaURL = dictionary.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            if let mediaURL = mediaURL {
                annotation.subtitle = mediaURL
            }
            
            
            // Finally we place the annotation in an array of annotations.
            self.annotations.append(annotation)
            self.mapView?.reloadInputViews()
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView?.addAnnotations(self.annotations)
    }

}
