//
//  AppDelegate.swift
//  ChaiGuru
//
//  Created by phanindhra on 2/6/19.
//  Copyright © 2019 phanindhra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var arrOfAllProducts : NSMutableArray! = NSMutableArray()
    
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
       
        if UserDefaultStored.userId == nil{
            UserDefaultStored.userId = ""
        }
        
        if UserDefaultStored.isLoggedIn == nil{
            UserDefaultStored.isLoggedIn = "0"
        }
        
        
        
        
        return true
        
    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController :UINavigationController!
        
      
        
        if UserDefaultStored.isLoggedIn == "1"{

           let initialViewController = storyboard.instantiateViewController(withIdentifier: "ChaiGuruTabBarViewController") as! ChaiGuruTabBarViewController

            initialViewController.selectedIndex = 0

            navigationController  = UINavigationController.init(rootViewController: initialViewController)

        }else{

           let initialViewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController

            navigationController  = UINavigationController.init(rootViewController: initialViewController)
        }



        navigationController.isNavigationBarHidden = true

        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()

        
        
        
        
        
        return true
        
        
        
       
    }

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

