//
//  SideScrollingTableViewContentCell.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/8/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit

enum ContentType {
    case popularTours
    case recentTours
    case userTours
    case sites
}

typealias SideScrollerAction = ((_ sender: SideScrollingTableViewContentCell)->())
typealias SideScrollerTourSelected = ((_ tour: Tour)->())
typealias SideScrollerSiteSelected = ((_ site: Site)->())

class SideScrollingTableViewContentCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    var contentType = ContentType.popularTours
    
    var didTouchSeeAllButton: SideScrollerAction?
    var tourSelected: SideScrollerTourSelected?
    var siteSelected: SideScrollerSiteSelected?

    @IBAction func seeAllButtonTouched(_ sender: UIButton) {
        didTouchSeeAllButton?(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        didTouchSeeAllButton = nil
        tourSelected = nil
        siteSelected = nil
    }
}

extension SideScrollingTableViewContentCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch contentType {
        case .popularTours:
            return DataManager.default.popularTours.count
        
        case .recentTours:
            return DataManager.default.newTours.count
            
        case .userTours:
            return DataManager.default.userTours.count
            
        case .sites:
            return DataManager.default.interestingSites.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! SideScrollingItemCollectionViewCell

        switch contentType {
        case .popularTours:
            let tour = DataManager.default.popularTours[indexPath.item]
            cell.titleLabel.text = tour.name
            cell.imageView.image = UIImage(named: tour.image)

        case .recentTours:
            let tour = DataManager.default.newTours[indexPath.item]
            cell.titleLabel.text = tour.name
            cell.imageView.image = UIImage(named: tour.image)
            
        case .userTours:
            let tour = DataManager.default.userTours[indexPath.item]
            cell.titleLabel.text = tour.name
            cell.imageView.image = #imageLiteral(resourceName: "UserTour")
            
            
        case .sites:
            let site = DataManager.default.interestingSites[indexPath.item]
            cell.titleLabel.text = site.name
            cell.imageView.image = UIImage(named: site.image)

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch contentType {
        case .popularTours:
            let tour = DataManager.default.popularTours[indexPath.item]
            tourSelected?(tour)
            break
            
        case .recentTours:
            let tour = DataManager.default.newTours[indexPath.item]
            tourSelected?(tour)
            break
            
        case .userTours:
            let tour = DataManager.default.userTours[indexPath.item]
            tourSelected?(tour)
            break
            
        case .sites:
            let site = DataManager.default.interestingSites[indexPath.item]
            siteSelected?(site)
            break
        }
    }
}









