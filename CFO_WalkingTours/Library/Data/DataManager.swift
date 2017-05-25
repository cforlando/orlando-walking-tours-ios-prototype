//
//  DataManager.swift
//  CFEOrlandoWalkingTours
//
//  Created by Adam Jawer on 5/4/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

class DataManager {
    static var `default` = DataManager()
    
    var sites = [Site]()
    
    var allTours = [Tour]()
    var featuredTour: Tour?
    
    var userTours: [Tour] {
        let tour = Tour()
        
        tour.id = "Personal 1"
        tour.name = "Personal Tour 1"
        tour.dscr = "These are some sites I like"
        tour.image = "UserTour"
        
        tour.sites.append(site(with: "-KNybua7eh_9n0YDORjj")!)
        tour.sites.append(site(with: "-KNybuaCvCAFHnaMjplz")!)
        tour.sites.append(site(with: "-KNybuaGa1-szSq2KLme")!)
        tour.sites.append(site(with: "-KNybuaJ47CdUrCRPCl3")!)

        let tour2 = Tour()
        
        tour2.id = "Personal 2"
        tour2.name = "Interesting"
        tour2.dscr = "These are some more sites I like"
        tour2.image = "UserTour"
        
        
        tour2.sites.append(site(with: "-KNybuaCvCAFHnaMjpm-")!)
        tour2.sites.append(site(with: "-KNybuaDRmB94WIUispz")!)
        tour2.sites.append(site(with: "-KNybuaDRmB94WIUisq-")!)
        tour2.sites.append(site(with: "-KNybuaDRmB94WIUisq0")!)
        tour2.sites.append(site(with: "-KNybuaDRmB94WIUisq1")!)
        tour2.sites.append(site(with: "-KNybuaE8GBt955ZTeTo")!)
        tour2.sites.append(site(with: "-KNybuaE8GBt955ZTeTp")!)
        tour2.sites.append(site(with: "-KNybuaE8GBt955ZTeTq")!)
        
        return [tour, tour2]
    }
    
    var popularTours: [Tour] {
        var counter = 0
        return allTours.sorted { $0.likes > $1.likes }.filter {_ in
            counter += 1
            return counter <= 5
        }
    }
    
    var newTours: [Tour] {
        return allTours.filter { $0.isNew }
    }
    
    var interestingSites: [Site] {
        var counter = 0
        return sites.sorted { $0.likes > $1.likes }.filter {_ in
            counter += 1
            return counter <= 5
        }
    }
    
    init() {
        // load the sample data
        if let url = Bundle.main.url(forResource: "OWTData", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: url)
                
                let allData = JSON(data)
                
                let orlandoSites = allData["orlando"]["historic-locations"]
            
                var index = 0
                
                for (siteId, json) in orlandoSites {
                    let imageNumber = index % 13
                    let imageName = "s\(imageNumber)"
                    let site = Site()
                    site.id = siteId
                    site.name = json["name"].stringValue
                    site.dscr = json["description"].stringValue
                    site.type = json["type"].stringValue
                    site.address = json["address"].stringValue
                    site.coordinate = CLLocationCoordinate2D(latitude: json["location"]["latitude"].doubleValue,
                                                             longitude: json["location"]["longitude"].doubleValue)
                    site.image = imageName
                    site.likes = Int(arc4random_uniform(100))
                    
                    
                    for (_ ,tagJson) in json["tags"] {
                        let tag = tagJson.stringValue
                        site.tags.append(tag)
                    }
                    
                    sites.append(site)
                    
                    index += 1
                }
                
                sites.sort { $0.name < $1.name }
                
                // TOURS
                let orlandoTours = allData["orlando"]["official-tours"]
                
                for (tourId, json) in orlandoTours {
                    let tour = Tour()
                    tour.id = tourId
                    tour.name = json["name"].stringValue
                    tour.dscr = json["dscr"].stringValue
                    tour.image = json["image"].stringValue
                    tour.likes = json["likes"].intValue
                    tour.isNew = json["isNew"].boolValue
                    
                    let sitesArray = json["sites"]
                    
                    for (_, siteIdJson) in sitesArray {
                        let siteId = siteIdJson.stringValue
                        if let site = site(with: siteId) {
                            tour.sites.append(site)
                        }
                    }
                    
                    allTours.append(tour)
                }
                
                let featuredTourId = allData["orlando"]["featuredTour"].stringValue
                featuredTour = allTours.filter { $0.id == featuredTourId }.first

            } catch {
                print("Error opening sample data")
            }
        }
    }
    
    func site(with siteId: String) -> Site? {
        return sites.filter { $0.id == siteId }.first
    }
}

class Site {
    var id: String!
    var name: String!
    var dscr: String!
    var type: String!
    var address: String!
    var coordinate: CLLocationCoordinate2D!
    var image: String!
    var likes = 0
    var tags = [String]()
}

class Tour {
    var id: String!
    var name: String!
    var dscr: String!
    var image: String!
    var likes = 0
    var isNew = false
    var sites = [Site]()
}
