//
//  AppDelegate.swift
//  CFO_WalkingTours
//
//  Created by Adam Jawer on 5/25/17.
//  Copyright © 2017 Adam Jawer. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let locationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        locationManager.requestWhenInUseAuthorization()
        
        return true
    }
    
    func switchToAllSites() {
        self.window?.rootViewController = createViewControllerNamed("SitesNavController")
    }
    
    func switchToMainViewController() {
        self.window?.rootViewController = createViewControllerNamed("MainTabBar")
    }
    
    func switchToHomeController() {
        self.window?.rootViewController = createViewControllerNamed("HomeViewController")
    }
    
    private func createViewControllerNamed(_ name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: name)
        
        return navController
    }
}

