//
//  CollectionCollectionViewCell.swift
//  BRAINBITmusic
//
//  Created by Sap on 29.02.2024.
//

import Foundation
import UIKit

class CollectionCollectionViewCell: UICollectionViewCell {
    static let reuseId = "CollectionCollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 19
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(mainImageView)
        
        layer.cornerRadius = 19
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0

        clipsToBounds = false
        layer.masksToBounds = false

        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 209).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 232).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
