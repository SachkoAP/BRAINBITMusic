//
//  PlaylistVC.swift
//  BRAINBITmusic
//
//  Created by Sap on 16.05.2024.
//

import UIKit

class PlaylistVC: UIViewController {
    
    var playlistInfo: CollectionCollection
        
    private let imagePlaylist: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var collectionViewTracks: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(playlistInfo: CollectionCollection) {
            self.playlistInfo = playlistInfo
            self.imagePlaylist.image = playlistInfo.image
            super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //service
        collectionViewTracks.register(TrackCollcectionViewCell.self, forCellWithReuseIdentifier: TrackCollcectionViewCell.reuseId)
        collectionViewTracks.dataSource = self
        
        let flowLayoutService = UICollectionViewFlowLayout()
        flowLayoutService.scrollDirection = .horizontal
        collectionViewTracks.collectionViewLayout = flowLayoutService
        collectionViewTracks.delegate = self
        collectionViewTracks.showsVerticalScrollIndicator = false
        collectionViewTracks.showsHorizontalScrollIndicator = false
        collectionViewTracks.backgroundColor = .clear
        
        view.addSubview(imagePlaylist)
        view.addSubview(collectionViewTracks)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            imagePlaylist.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagePlaylist.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
            imagePlaylist.heightAnchor.constraint(equalToConstant: 209),
            imagePlaylist.widthAnchor.constraint(equalToConstant: 232),

            collectionViewTracks.topAnchor.constraint(equalTo: imagePlaylist.bottomAnchor, constant: 50),
            collectionViewTracks.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionViewTracks.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionViewTracks.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
        ])
    }

    
}


extension PlaylistVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlistInfo.listTracks.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollcectionViewCell.reuseId, for: indexPath) as! TrackCollcectionViewCell
        cell.mainImageView.image = playlistInfo.listTracks[indexPath.row].image
        cell.nameTrack.text = playlistInfo.listTracks[indexPath.row].name
        cell.nameWriter.text = playlistInfo.listTracks[indexPath.row].nameWriter
        return cell
    }
}

extension PlaylistVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}

extension PlaylistVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Player()
        vc.trackOneInfo = [playlistInfo.listTracks[indexPath.row]]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
