//
//  MapViewController.swift
//  CFOOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/15/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit
import MapKit

class SiteAnnotation: MKPointAnnotation {
    var siteId: String!
}

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        for site in DataManager.default.sites {
            let annotation = SiteAnnotation()
            annotation.siteId = site.id
            annotation.coordinate = site.coordinate
            annotation.title = site.name
            annotation.subtitle = site.address
            
            mapView.addAnnotation(annotation)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSite" {
            if let controller = segue.destination as? SiteDetailViewController,
                let site = sender as? Site {
                controller.site = site
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "sitePin")
        
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .infoDark)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let siteId = (view.annotation as? SiteAnnotation)?.siteId,
            let site = DataManager.default.site(with: siteId) {
            performSegue(withIdentifier: "showSite", sender: site)
        }
    }
}
