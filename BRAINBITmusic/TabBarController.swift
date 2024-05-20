//
//  TabBarController.swift
//  BRAINBITmusic
//
//  Created by Sap on 13.05.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupApperance()

    }
    
    private func setupApperance(){
        tabBar.tintColor = .gray
        tabBar.barTintColor = .gray
    }
    
    private func setupViewControllers() {
        
        let vc = GlavnaiaVC()
        let nc1 = UINavigationController(rootViewController: vc)
        vc.view.backgroundColor = .black
        
        let vc2 = SearchDeviceVC()
        let nc2 = UINavigationController(rootViewController: vc2)
        vc2.view.backgroundColor = .black
        
        let vc3 = SearchVC()
        let nc3 = UINavigationController(rootViewController: vc3)
        vc3.view.backgroundColor = .black
        
        let vc4 = MyTrackVC()
        let nc4 = UINavigationController(rootViewController: vc4)
        vc4.view.backgroundColor = .black

        tabBar.standardAppearance = UITabBarAppearance()

        setViewControllers(
            [nc1, nc2, nc3, nc4],
            animated: false)
    }
    
}
