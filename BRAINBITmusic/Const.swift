//
//  Const.swift
//  BRAINBITmusic
//
//  Created by Sap on 28.12.2023.
//

import Foundation
import UIKit


enum Image {
    enum Instrucrion {
        static var instructionBAcgroundImage = UIImage(named: "instructionBI")
        static var buttonDone = UIImage(named: "buttonDone")
    }
    
    enum Glavnaia {
        static var glavnaiaTabBarImage = UIImage(named: "glavnaiaTabBarImage")
        
        static var wheareListen = UIImage(named: "wheareListen")
        static var photoUser = UIImage(named: "photoUser")
        static var nameUser = UIImage(named: "nameUser")
        static var photoNoRegUser = UIImage(named: "photoNoRegUser")
        
        static var imageYandexCVC = UIImage(named: "YandexCVC")
        static var iamgeVKCVC = UIImage(named: "VKCVC")
        static var imageSpotifyCVC = UIImage(named: "SpotifyCVC")
        static var imageAppleMusicCVC = UIImage(named: "AppleMusicCVC")
        
        static var ourSelection = UIImage(named: "ourSelection")
        
        static var imageRelaxCVC = UIImage(named: "RelaxCVC")
        static var imageSleepCVC = UIImage(named: "SleepCVC")
        static var imageWorkCVC = UIImage(named: "WorkCVC")
        
        static var backGroundNotConnectedDevice = UIImage(named: "backGroundNotConnectedDevice")
    }
    
    enum Player {
        static var buttonLeftMusic = UIImage(named: "buttonLeftMusic")
        static var buttonPlayMusic = UIImage(named: "buttonPlayMusic")
        static var buttonRightMusic = UIImage(named: "buttonRightMusic")
        
        static var imageFromTrack = UIImage(named: "imageFromTrack")
        static var imageFromTrack2 = UIImage(named: "imageFromTrack2")
        static var imageVhod = UIImage(named: "Vhod")
    }
    
    enum SearchDevice {
        static var myDeviceTitle = UIImage(named: "myDevice")
        static var deviceTabBarImage = UIImage(named: "deviceTabBarImage")
    }
    
    enum MyTrack {
        static var mytrackTabBarImage = UIImage(named: "myTrackTabBarImage")
    }
    
    enum Search {
        static var searchTabBarImage = UIImage(named: "searchTabBarImage")
    }
}
