//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController: MainTabBarController?
    lazy var coreDataStack = CoreDataStack(modelName: "Reciplease")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        tabBarController = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.tintColor = .brown
        window?.makeKeyAndVisible()
        return true
    }
}
