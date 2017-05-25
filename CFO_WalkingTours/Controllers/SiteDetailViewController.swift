//
//  SiteDetailViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/4/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit
import MapKit

class SiteDetailViewController: UIViewController {

    var site: Site!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = site.name
    }
}

private enum SiteDetailRegion: Int {
    case image = 0
    case map
    case description
    case likes
    case tags
    case actions
    
    case rowCount
}

extension SiteDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SiteDetailRegion.rowCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch SiteDetailRegion(rawValue: indexPath.row)! {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! SiteDetailImageCell
            cell.siteImage.image = UIImage(named: site.image)
            return cell
            
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell") as! SiteDetailMapViewCell
            cell.addressLabel.text = site.address
            
            let regionRadius: CLLocationDistance = 400
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(
                site.coordinate,
                regionRadius * 2,
                regionRadius * 2)
            cell.mapView.setRegion(coordinateRegion, animated: false)

            // remove any existing annotations
            cell.mapView.removeAnnotations(cell.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = site.coordinate
            cell.mapView.addAnnotation(annotation)
            
            return cell
            
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "wrappingTextCell") as! SiteDetailWrappingTextCell
            cell.wrappingLabel.text = site.dscr
            return cell
            
        case .likes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "likesCell") as! SiteDetailLikesCell
            cell.likeCountLabel.text = "\(site.likes)"
            return cell
            
        case .tags:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell") as! SiteDetailTagsCell
            
            var tagString = ""
            for tag in site.tags {
                if tagString.characters.count > 0 {
                    tagString += ";"
                }
                tagString += tag
            }
            
            cell.tagsView.tags = tagString
            
            
            return cell
            
        case .actions:
            let cell = tableView.dequeueReusableCell(withIdentifier: "placeholderCellId")!
            cell.textLabel?.text = "Actions"
            return cell
            
        default: // This will never happen
            return UITableViewCell()
        }
    }
}

class SiteDetailImageCell: UITableViewCell {
    @IBOutlet weak var siteImage: UIImageView!
}

class SiteDetailWrappingTextCell: UITableViewCell {
    @IBOutlet weak var wrappingLabel: UILabel!
}

class SiteDetailMapViewCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
}

class SiteDetailLikesCell: UITableViewCell {
    @IBOutlet weak var thumbsImage: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
}

class SiteDetailTagsCell: UITableViewCell {
    @IBOutlet weak var tagsView: TagStackView!
}
