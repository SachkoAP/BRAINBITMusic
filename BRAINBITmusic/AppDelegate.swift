//
//  AppDelegate.swift
//  BRAINBITmusic
//
//  Created by Sap on 28.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        let mainView = InstructionVC(nibName: nil, bundle: nil) //ViewController = Name of your controller
        nav1.viewControllers = [mainView]
        nav1.navigationBar.isHidden = true
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()

        return true
    }

}

