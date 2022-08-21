//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 16/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let tabbarViewController = TabBarController()
        let navigationVC = UINavigationController(rootViewController: tabbarViewController)
        navigationVC.navigationBar.topItem?.title = "Movies"
        navigationVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationVC.navigationBar.backgroundColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        window?.rootViewController = navigationVC
        return true
    }
}

