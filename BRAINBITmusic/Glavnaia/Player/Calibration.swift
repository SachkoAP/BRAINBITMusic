//
//  Calibretion.swift
//  BRAINBITmusic
//
//  Created by Sap on 25.04.2024.
//

import Foundation
import UIKit

class Calibration {
    
    public func exponentialSmoothing(data: [Float], alpha: Float) -> [Float] {
        guard !data.isEmpty else { return [] }
    
        var smoothedData = [Float]()
        var lastSmoothedValue = data[0]
    
        for value in data {
            let smoothedValue = alpha * value + (1 - alpha) * lastSmoothedValue
            smoothedData.append(smoothedValue)
            lastSmoothedValue = smoothedValue
        }
    
        return smoothedData
    }

}

class TrackMassiv {
    var massiv: [TrackInfo] = []
}
