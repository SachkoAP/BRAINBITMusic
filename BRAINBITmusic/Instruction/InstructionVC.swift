//
//  ViewController.swift
//  BRAINBITmusic
//
//  Created by Sap on 28.12.2023.
//

import UIKit

class InstructionVC: UIViewController {
    
    let bacgroundImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = Image.Instrucrion.instructionBAcgroundImage
        return image
    }()
    
    private var buttonDone : UIButton = {
        let button = UIButton()
        button.setImage(Image.Instrucrion.buttonDone, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(bacgroundImage)
        view.addSubview(buttonDone)

        setupConstraint()
        addActions()
    }
    
    private func addActions(){
        
        buttonDone.addAction(UIAction(handler: { [weak self] _ in
            let vc = GlavnaiaVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            bacgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            bacgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bacgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bacgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonDone.topAnchor.constraint(equalTo: view.topAnchor,constant: 415),
            buttonDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14)
        ])
    }
}

