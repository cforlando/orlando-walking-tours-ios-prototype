//
//  SitesTableViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/4/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var siteAddress: UILabel!
}

class SitesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        (UIApplication.shared.delegate as! AppDelegate).switchToHomeController()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.default.sites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siteCell", for: indexPath) as! SiteTableViewCell

        let site = DataManager.default.sites[indexPath.row]
        
        cell.siteName.text = site.name
        cell.siteAddress.text = site.address
        cell.siteImage.image = UIImage(named: site.image)

        return cell
    }
}
