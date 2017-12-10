//
//  AppDelegate.swift
//  Zendo
//
//  Created by Martine Habib on 12/1/17.
//  Copyright © 2017 NagTime. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var onHelpPage = false
    let notifCenter = NotificationCenter.default
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        notifCenter.addObserver(self, selector: #selector(self.switchToHelpPage), name: Notification.Name(rawValue: "getHelpPage"), object: nil)
        // Override point for customization after application launch.
        switchToHelpPage()
        return true
    }
    
    // If we have nothing in the list of tasks, show the CreateTaskPage.
    @objc func switchToHelpPage()
    {
        // Collect our nag tasks
        let sessionList = SessionEngine.sharedInstance.allItems()
        
        let navigationController = self.window!.rootViewController as!UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewControllers = navigationController.viewControllers
        
       for viewController in viewControllers {
            // if we are already on the Session page, we need to go back to the list..
           if viewController.isKind(of: SessionViewController.self) {
            let navigationController = UIApplication.shared.windows[0].rootViewController as! UINavigationController
            navigationController.popToRootViewController(animated: true)
            }
        }
        
        // If we don't have any items, go to new task page
        if sessionList.count == 0 { // AND the actual notification count is under 64
            let newTaskView = mainStoryboard.instantiateViewController(withIdentifier: "HelpView") as! HelpViewController
            navigationController.pushViewController(newTaskView, animated: false)
            
        }
        onHelpPage = true
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        NotificationCenter.default.post(name: Notification.Name(rawValue: "earlyExit"), object: self)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
            switchToHelpPage()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("Will Terminate")
    }


}

