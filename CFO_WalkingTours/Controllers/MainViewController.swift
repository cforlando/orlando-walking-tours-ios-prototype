//
//  MainViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/8/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTour" {
            let controller = segue.destination as! TourDetailTableViewController
            controller.tour = sender as? Tour
        } else if segue.identifier == "showSite" {
            let controller = segue.destination as! SiteDetailViewController
            controller.site = sender as? Site
        }
    }
    
}

private enum MainTourRegion: Int {
    case featuredTour = 0
    case popularTour
    case recentlyAddedTours
    case myTours
    case sites
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainTourRegion.sites.rawValue + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let showAllTours: SideScrollerAction = {_ in
            self.performSegue(withIdentifier: "showAllTours", sender: nil)
        }
        
        switch MainTourRegion(rawValue: indexPath.row)! {
        case .featuredTour:
            let cell = tableView.dequeueReusableCell(withIdentifier: "featuredTourCellId")!
            return cell
            
        case .popularTour:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toursCellId")! as! SideScrollingTableViewContentCell
            cell.titleLabel.text = "Highest Rated Tours"
            cell.contentType = .popularTours
            cell.didTouchSeeAllButton = showAllTours
            cell.tourSelected = { tour in
                self.performSegue(withIdentifier: "showTour", sender: tour)
            }
            return cell

        case .recentlyAddedTours:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toursCellId")! as! SideScrollingTableViewContentCell
            cell.titleLabel.text = "New Tours"
            cell.contentType = .recentTours
            cell.didTouchSeeAllButton = showAllTours
            cell.tourSelected = { tour in
                self.performSegue(withIdentifier: "showTour", sender: tour)
            }
            return cell

        case .sites:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toursCellId")! as! SideScrollingTableViewContentCell
            cell.titleLabel.text = "Popular Historic Sites"
            cell.contentType = .sites
            cell.didTouchSeeAllButton = { _ in
                self.performSegue(withIdentifier: "showAllSites", sender: nil)
            }
            cell.siteSelected = { site in
                self.performSegue(withIdentifier: "showSite", sender: site)
            }
            return cell

        case .myTours:
            let cell = tableView.dequeueReusableCell(withIdentifier: "toursCellId")! as! SideScrollingTableViewContentCell
            
            cell.titleLabel.text = "My Personal Tours"
            
            cell.contentType = .popularTours
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == MainTourRegion.featuredTour.rawValue {
            performSegue(withIdentifier: "showTour", sender: DataManager.default.featuredTour)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch MainTourRegion(rawValue: indexPath.row)! {
        case .featuredTour:
            return 150
        default:
            return 195
        }
    }
}
