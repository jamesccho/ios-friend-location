//
//  MapViewController.swift
//  FriendLocationSample
//
//  Created by James Chan on 5/4/2018.
//  Copyright © 2018 James Chan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    var friend: Friend
    var mapView: MKMapView?
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = friend.name
        
        self.mapView = MKMapView(frame: self.view.frame)
        self.mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView?.delegate = self
        self.view.addSubview(self.mapView!)
        
//        let mapCoordinate = CLLocationCoordinate2D(latitude: 22.273509, longitude: 114.181034)
        let mapCoordinate = CLLocationCoordinate2D(latitude: self.friend.location.latitude, longitude: self.friend.location.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(mapCoordinate, span)
        mapView?.region = region
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapCoordinate
        annotation.title = friend.name
        mapView?.addAnnotation(annotation)
        
        print("\(friend.name, friend.location.latitude, friend.location.longitude)")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView?.selectAnnotation((mapView?.annotations[0])!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            return nil
        } else {
            let pinIdent = "Pin"
            var pinView: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                pinView = dequeuedView
            } else {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent)
            }
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = UIColor.orange
            return pinView;
        }
    }

}
