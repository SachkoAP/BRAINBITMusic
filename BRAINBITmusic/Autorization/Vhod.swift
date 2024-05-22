//
//  Vhod.swift
//  BRAINBITmusic
//
//  Created by Sap on 29.02.2024.
//

import UIKit
import 

class Vhod: UIViewController {
    private let trackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Image.Player.imageVhod
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(trackImage)

    }
    private func setConstrains(){
        
        NSLayoutConstraint.activate([
            trackImage.topAnchor.constraint(equalTo: view.topAnchor),
            trackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trackImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
