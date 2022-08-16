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
        let viewController = ViewController()
        viewController.loader = RemoteMovieManager()
        window?.rootViewController = viewController
        return true
    }
}

