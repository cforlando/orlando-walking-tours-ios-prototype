//
//  HomeViewController.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/4/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit
import KBImageView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var toursButton: UIButton!
    @IBOutlet weak var backgroundImageView: KBImageView!
    
    fileprivate var imageNames = [
                                  "BUMBY HARDWARE BUILDING",
                                  "DR. WILLIAM MONROE WELLS HOUSE",
                                  "EBENEZER METHODIST CHURCH",
                                  "FIRST NATIONAL BANK",
                                  "HANKINS BUILDING",
                                  "KRESS BUILDING",
                                  "MOUNT PLEASANT BAPTIST CHURCH",
                                  "NICHOLSON-COLYER BUILDING",
                                  "OLD ORLANDO RAILROAD DEPOT",
                                  "ORLANDO BANK & TRUST COMPANY",
                                  "SLEMONS DEPARTMENT STORE",
                                  "VICTORIAN HOUSE & COTTAGE",
                                  "WELLS’BUILT HOTEL"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageNames = imageNames.shuffled()
        imageNames.insert("Lake Eola Fountain", at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toursButton.layer.borderColor = UIColor.black.cgColor
        toursButton.layer.borderWidth = 3
        
        _ = DataManager.default.sites
    }
    
    @IBAction func showSites(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).switchToMainViewController() //switchToAllSites()
    }
}

extension HomeViewController: KBImageViewDelegate {
    func numberOfImages(in imageView: KBImageView!) -> UInt {
        return UInt(imageNames.count)
    }
    
    func imageView(_ imageView: KBImageView!, imageFor index: UInt) -> UIImage! {
        let image = UIImage(named: imageNames[Int(index)])
        return image
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffle()
        return list
    }
}
