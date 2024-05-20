//
//  ImageService.swift
//  BRAINBITmusic
//
//  Created by Sap on 28.02.2024.
//

import UIKit

struct ServiceCollection {
    let id: Int
    let image: UIImage
}

struct CollectionCollection {
    let id: Int
    let image: UIImage
    let listTracks: [TrackInfo]
}

struct PlaylistCollection {
    let id: Int
    let image: UIImage
    let listTracks: [TrackInfo]
}
