//
//  MapViewController.swift
//  On The Map
//
//  Created by Ayush Garg on 28/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: NavBarViewController, MKMapViewDelegate {
    
    var annotations = [MKPointAnnotation]()
    @IBOutlet var mapView: MKMapView!
    var studentData: [Students] = [Students]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
        
        
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

    override func viewWillAppear(_ animated: Bool) {
        oParseClient.fetchStudentsData(forNumberOfStudents: 100, inAscending: false, pagesToSkip: 0){ (data, success, error) in
            if success {
                if let data = data?["results"] as? [[String:AnyObject]]{
                    self.studentData = Students.studentsFromResults(results: data)
                    for dictionary in self.studentData {
                        // Notice that the float values are being used to create CLLocationDegree values.
                        // This is a version of the Double type.
                        let lat = CLLocationDegrees(dictionary.latitude!)
                        let long = CLLocationDegrees(dictionary.longitude!)
                        
                        // The lat and long are used to create a CLLocationCoordinates2D instance.
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        let first = dictionary.firstName!
                        let last = dictionary.lastName!
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
                        self.mapView.reloadInputViews()
                    }
                    
                    // When the array is complete, we add the annotations to the map.
                    self.mapView.addAnnotations(self.annotations)
                }
            }
        }
        mapView.reloadInputViews()
    }

}
