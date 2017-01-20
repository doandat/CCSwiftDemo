//
//  AppDelegate.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/13/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navitaion:BaseNavigationController?
    
    var container: MFSideMenuContainerViewController?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        makeRootViewController()

        
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

    //Mark:
    
    func makeRootViewController()
    {
        let homeVC = HomeViewController(nibName: nil, bundle: nil)
        let naviHome = BaseNavigationController(rootViewController: homeVC)
        
        let sideBarVC = SideBarViewController(nibName: nil, bundle: nil)
        
        container = MFSideMenuContainerViewController()
        container?.leftMenuViewController   = sideBarVC
        container?.centerViewController     = naviHome
        
        self.window?.rootViewController = container
        self.window!.makeKeyAndVisible()
        
    }
    
    
    func makeRootViewController222()
    {
        
        let pVC = ListTransitionViewController(nibName: nil, bundle: nil)
        
        
        let pNavi = AnimatableNavigationController(rootViewController: pVC)
//        pNavi.viewControllers = [pVC]
        
        
        self.window?.rootViewController = pNavi
        self.window!.makeKeyAndVisible()
        
    }

    
}




/*
 ///Test

 func test()
 {
 
 self.showLoading()
 
 APIClient.sharedInstance.getLocationUser {
 [weak self] responseObject, error in
 
 guard let strongSelf = self else { return }
 
 strongSelf.hideLoading()
 
 if(CommonUtil.isCallAPIErrorNotDetermine(result: responseObject!))
 {
 
 }
 else if(CommonUtil.isNeedRefreshToken(result: responseObject!))
 {
 
 }
 else if(CommonUtil.isCallAPISuccess(result: responseObject!))
 {
 if let result = responseObject?.value as? Dictionary<String, AnyObject>
 {
 print(result)
 
 if let dictAccount = result["data"] as? Dictionary<String, AnyObject>
 {
 let account = Account(JSON: dictAccount)
 
 print(account?.name)
 }
 }
 
 }
 else
 {
 
 }
 }
 
 
 //        APIClient.sharedInstance.createUser(device_token: "aaa", device_id: "aa") {
 //            [weak self] responseObject, error in
 //
 //            guard let strongSelf = self else { return }
 //
 //
 //            if let result = responseObject?.value as? Dictionary<String, AnyObject>
 //            {
 //                print(result)
 //            }
 //        }
 
 
 }
 */


