//
//  TrackCollcectionViewCell.swift
//  BRAINBITmusic
//
//  Created by Sap on 16.05.2024.
//

import Foundation
import UIKit

//struct TrackInfoList {
//    var image: UIImage
//    var name: String
//    var nameWriter: String
//}
//

class TrackCollcectionViewCell: UICollectionViewCell {
    static let reuseId = "TrackCollcectionViewCell"
//    var trackOneInfo = [TrackInfo]()
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let nameTrack: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()
    
    let nameWriter: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        mainImageView.image = trackOneInfo[0].image
//        nameTrack.text = trackOneInfo[0].name
//        nameWriter.text = trackOneInfo[0].nameWriter
        
        addSubview(mainImageView)
        addSubview(nameTrack)
        addSubview(nameWriter)

        
        layer.cornerRadius = 19
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        
//        backgroundColor = .blue

        clipsToBounds = false
        layer.masksToBounds = false
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 42),
            mainImageView.widthAnchor.constraint(equalToConstant: 42),
            
            nameTrack.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor, constant: -5),
            nameTrack.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 20),
            
            nameWriter.centerYAnchor.constraint(equalTo: nameTrack.bottomAnchor, constant: 5),
            nameWriter.leadingAnchor.constraint(equalTo: nameTrack.leadingAnchor)
        ])
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
