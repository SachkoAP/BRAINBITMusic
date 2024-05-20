//
//  CollectionOpenOne.swift
//  BRAINBITmusic
//
//  Created by Sap on 29.02.2024.
//

import UIKit

class CollectionOpenOne: UIViewController {
//    var cellsCoffeOpenOne = CoffeCollection(id: 0, title: "", subTitle: "", image: UIImage(), description: "", createdAt: "")
    
    private lazy var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.backgroundColor = .none
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 320)
        UIScrollView.appearance().bounces = false
        return scroll
    }()
    private lazy var contentView: UIView = {
       let content = UIView()
        content.backgroundColor = .none
        content.frame.size = CGSize(width: view.frame.width, height: view.frame.height + 320)
        return content
    }()
    private let collectionNameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    private let track: UIButton = {
        let button = UIButton(type: .custom)
//        button.backgroundColor = UIColor(rgb: 0x247018)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(rgb: 0x3E3A3A)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionNameImage)
        contentView.addSubview(track)
        setConstrains()
        addActions()
    }
    
// MARK: AddActions
    private func addActions(){
        //buttonFresh Action
        track.addAction(UIAction(handler: { [weak self] _ in
//            let launchPage = ViewController()
//            launchPage.modalPresentationStyle = .fullScreen
//            self?.present(launchPage, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
            
//MARK: setConstrains
        
    private func setConstrains(){
        
        NSLayoutConstraint.activate([
            collectionNameImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            collectionNameImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionNameImage.heightAnchor.constraint(equalToConstant: 420),
            collectionNameImage.widthAnchor.constraint(equalToConstant: 345),
        ])
    }

}
