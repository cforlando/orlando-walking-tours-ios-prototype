//
//  MainSectionTitleHeader.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/8/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit

class MainSectionTitleHeader: UIView {

    var seeAllPressed: ((_ sender: MainSectionTitleHeader)->())?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    @IBAction func didPressSeeAll(_ sender: UIButton) {
        seeAllPressed?(self)
    }    
}
