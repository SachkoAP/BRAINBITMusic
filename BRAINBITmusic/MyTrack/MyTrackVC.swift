//
//  MyTrackVC.swift
//  BRAINBITmusic
//
//  Created by Sap on 13.05.2024.
//

import UIKit

class MyTrackVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbarItem()
    }
    
    private func setupTabbarItem() {
        tabBarItem = UITabBarItem(
            title: "",
            image: Image.MyTrack.mytrackTabBarImage,
            tag: 4
        )
    }

}
