//
//  TourDetailTableViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/15/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit
import MapKit

class TourDetailMapCell: UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    
    func configure(with sites: [Site]) {
        var annotations = [MKAnnotation]()
        
        for site in sites {
            let annotation = MKPointAnnotation()
            annotation.coordinate = site.coordinate
            annotation.title = site.name
            annotation.subtitle = site.address
            
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: false)
    }
}

class TourDetailTableViewController: UITableViewController {

    var tour: Tour! {
        didSet {
            navigationItem.title = tour?.name
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    // MARK: - Table view data source

    private enum TourDetailSection: Int {
        case description
        case map
        case sites
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TourDetailSection(rawValue: section)! {
        case .description:
            return 1
        case .map:
            return 1
        case .sites:
            return tour.sites.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TourDetailSection(rawValue: indexPath.section)! {
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TourDescriptionCell", for: indexPath)
            cell.textLabel?.text = tour.dscr
//            cell.textLabel?.text = "This is a section to contain some descriptive information about the tour."
            return cell
            
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TourMapCell", for: indexPath) as! TourDetailMapCell
            
            cell.configure(with: tour.sites)
            
            return cell
            
        case .sites:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TourSiteCell", for: indexPath) as! SiteTableViewCell
            
            let site = tour.sites[indexPath.row]
            
            cell.siteName.text = site.name
            cell.siteAddress.text = site.address
            cell.siteImage.image = UIImage(named: site.image)
            
            return cell
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSite" {
            let controller = segue.destination as! SiteDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let site = DataManager.default.sites[indexPath.row]
                
                controller.site = site
            }
        }
    }
}
