//
//  SearchCollectionViewCell.swift
//  BRAINBITmusic
//
//  Created by Sap on 04.04.2024.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let reuseId = "SearchCollectionViewCell"
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0 // Для многострочного текста
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(rgb: 0x626262)
        label.textAlignment = .right
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black // Черный цвет линии
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(mainLabel)
        addSubview(statusLabel) // Добавление подписи о статусе в ячейку
        addSubview(lineView) // Добавление линии в ячейку
        
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0

        clipsToBounds = false
        layer.masksToBounds = false

        // Установка ограничений для mainLabel
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Установка ограничений для statusLabel
//        statusLabel.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 10).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        // Установка ограничений для lineView
        lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9).isActive = true
        lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9).isActive = true
        lineView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true // Высота линии
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
