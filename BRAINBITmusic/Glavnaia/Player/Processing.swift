//
//  Processing.swift
//  BRAINBITmusic
//
//  Created by Sap on 24.04.2024.
//

import Foundation

// Структура для хранения данных mindData
struct EMMindData1 {
    var instRelaxation: [Double]
    var instAttention: [Double]
}

class ProcessingDataWithBrainBit {
    private func processMindData(mindData: EMMindData1) -> Double {
        // Заполнение массивов сигналов для каждой группы
        let relaxationSignals = mindData.instRelaxation
        let attentionSignals = mindData.instAttention
                
        // Обработка каждой группы данных
        let processedMindData = processGroupData(relaxationSignals: relaxationSignals, attentionSignals: attentionSignals)
        
        // Вывод обработанных данных
        return processedMindData
    }
    
    private func processGroupData(relaxationSignals: [Double], attentionSignals: [Double]) -> Double {
        // Применение метода межквартального размаха (IQR) к каждой группе
        let processedRelaxationSignals = applyIQR(data: relaxationSignals)
        let processedAttentionSignals = applyIQR(data: attentionSignals)
        
        // Вычисление среднего значения для каждой группы
        let relaxationMean = calculateMean(data: processedRelaxationSignals)
        let attentionMean = calculateMean(data: processedAttentionSignals)
        
        let result: Float
        if attentionMean > relaxationMean {
            result = Float(attentionMean - relaxationMean)
        } else {
            result = Float(-(relaxationMean - attentionMean))
        }

        // Возвращаем обработанные данные
        return Double(result)
    }
    
    private func applyIQR(data: [Double]) -> [Double] {
        guard !data.isEmpty else { return [] }
        let sortedData = data.sorted()
        let q1 = sortedData[Int(Double(sortedData.count) * 0.25)]
        let q3 = sortedData[Int(Double(sortedData.count) * 0.75)]
        let iqr = q3 - q1
        let lowerBound = q1 - 1.5 * iqr
        let upperBound = q3 + 1.5 * iqr
        return data.filter { $0 >= lowerBound && $0 <= upperBound }
    }

    private func calculateMean(data: [Double]) -> Double {
        guard !data.isEmpty else { return 0 }
        let sum = data.reduce(0, +)
        return sum / Double(data.count)
    }
    
    public func getAnswerMindData(_ mindData: [String: [Double]] ) -> Double{
        var dataForProcessing: EMMindData1 = .init(instRelaxation: mindData["relax"] ?? [0.0], instAttention: mindData["concentration"] ?? [0.0])
        return processMindData(mindData: dataForProcessing)
    }
}

