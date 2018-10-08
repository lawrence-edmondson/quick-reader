//
//  AppDelegate.swift
//  quick-read
//
//  Created by Lawrence Edmondson on 10/3/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit
import CoreData
import Material
import Graph

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func applicationDidFinishLaunching(_ application: UIApplication) {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            let categories:[String] = ["MUSIC", "CULTURE", "TECH"]
            let newsData = NewsData()
            newsData.getData(currentPage:1, categories: categories) {(success) in
                
            let time: Double = 2.2
            let waitTime:DispatchTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(time*500))
            dispatchGroup.wait(timeout: waitTime)
            dispatchGroup.leave()
            
            if (success) {
                dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                    var viewControllers = [UIViewController]()
                    for category in categories {
                        viewControllers.append(NewsViewCollectionController(category: category))
                    }
                    let tabsController = AppTabsController(viewControllers: viewControllers)
                    let toolbarController = AppToolbarController(rootViewController: tabsController)
                    let menuController = AppNavigationController(rootViewController: toolbarController)
                    self.window = UIWindow(frame: Screen.bounds)
                    self.window!.rootViewController = menuController
                    self.window?.makeKeyAndVisible()
                    
                    
                })
            } else {
                //print("Error getting data")
            }
        }
    }

    
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

