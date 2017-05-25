//
//  AllToursViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/9/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit

class AllToursViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTour" {
            if let controller = segue.destination as? TourDetailTableViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first {
            
                let tour = DataManager.default.allTours[indexPath.item]
                
                controller.tour = tour
            }
        }
    }
    
}

extension AllToursViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.default.allTours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tourCellId", for: indexPath) as! AllToursCollectionViewCell
        
        let tour = DataManager.default.allTours[indexPath.item]
        
        cell.tourNameLabel.text = tour.name
        cell.imageView.image = UIImage(named: tour.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 24
        let height = width + 36
        return CGSize(width: width, height: height)
    }
}

class AllToursCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tourNameLabel: UILabel!
    
}
