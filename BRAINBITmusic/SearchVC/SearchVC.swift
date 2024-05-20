//
//  SearchVC.swift
//  BRAINBITmusic
//
//  Created by Sap on 13.05.2024.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbarItem()
    }
    

    private func setupTabbarItem() {
        tabBarItem = UITabBarItem(
            title: "",
            image: Image.Search.searchTabBarImage,
            tag: 3
        )
    }

}
