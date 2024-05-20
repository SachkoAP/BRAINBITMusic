//
//  Player.swift
//  BRAINBITmusic
//
//  Created by Sap on 29.02.2024.
//

import UIKit
import MediaPlayer
import EmStArtifacts

struct TrackInfo {
    var image: UIImage
    var name: String
    var nameWriter: String
    var dataCalibration: [Double]
}

class Player: UIViewController {
    var trackOneInfo = [TrackInfo]() {
        didSet {
            dataDictionary["relax"] = []
            dataDictionary["concentration"] = []
        }
    }
    var player : AVPlayer!
    var dataDictionary: [String: [Double]] = ["relax": [], "concentration": []]
    private var emotionsImpl : EmotionsImpl = EmotionsImpl()
    private let trackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    private let nameTrack: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()
    private let nameWriter: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = .white
        slider.setThumbImage(UIImage(), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    private let currentTimeLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()
    private let remainingTimeLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        return text
    }()
    private let buttonLeft: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.Player.buttonLeftMusic, for: .normal)
        return button
    }()
    private let buttonPlay: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.Player.buttonPlayMusic, for: .normal)
        return button
    }()
    private let buttonRight: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.Player.buttonRightMusic, for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        trackImage.image = trackOneInfo[0].image
        nameTrack.text = trackOneInfo[0].name
        nameWriter.text = trackOneInfo[0].nameWriter
        
        DispatchQueue.main.async {
            self.player = AVPlayer(url: URL(string: "https://fotodushi.ru/mus/priroda/01_Leo_Rojas-Serenade_to_Mother_Earth.mp3")!)
            
            self.currentTimeLabel.text = "0:00"
            
            if let duration = self.player.currentItem?.asset.duration, !duration.isIndefinite {
                let totalSeconds = CMTimeGetSeconds(duration)
                self.remainingTimeLabel.text = self.formatTime(seconds: totalSeconds)
            } else {
                self.remainingTimeLabel.text = "0:00" // Запасное значение, если длительность неизвестна
            }
            
            // Настройка таймера для регулярного обновления времени
            let interval = CMTime(value: 1, timescale: 2) // Обновлять каждые 0.5 секунды
            self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                self?.updateTimeLabels()
            }
        }


        emotionsImpl.initEmotionMath()
        emotionsImpl.calibrationProgressCallback = showCalibrationProgress
        emotionsImpl.showLastMindDataCallback = showLastMindData

        
        view.addSubview(trackImage)
        view.addSubview(nameTrack)
        view.addSubview(nameWriter)
        view.addSubview(slider)
        view.addSubview(currentTimeLabel)
        view.addSubview(remainingTimeLabel)
        view.addSubview(buttonLeft)
        view.addSubview(buttonPlay)
        view.addSubview(buttonRight)
        
        setConstrains()
        addActions()
    }
    
    private func showCalibrationProgress(_ progress: UInt32) {
        DispatchQueue.main.async { [self] in
            print("Calibration \(String(format: "%d", progress))")
        }
    }

    private func showLastMindData(mindData: EMMindData) {
        DispatchQueue.main.async { [self] in
            let relaxation = mindData.instRelaxation
            let attention = mindData.instAttention
            dataDictionary["relax"]?.append(relaxation)
            dataDictionary["concentration"]?.append(attention)
        }
    }

    func updateTimeLabels() {
           let currentTime = CMTimeGetSeconds(player.currentTime())
           let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
           let remainingTime = duration - currentTime
           
           currentTimeLabel.text = formatTime(seconds: currentTime)
           remainingTimeLabel.text = "-\(formatTime(seconds: remainingTime))"
       }
       
    func formatTime(seconds: Double) -> String {
        guard !(seconds.isNaN || seconds.isInfinite) else {
            return "00:00"
        }
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        if hours > 0 {
            return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }

    // MARK: AddActions
        private func addActions(){
            //buttonFresh Action
            buttonPlay.addAction(UIAction(handler: { [weak self] _ in
                if self!.player.rate > 0 {
                    self!.player.pause()
                    self!.emotionsImpl.stop()
//                    print()
                    self!.addTrackToMassiv()
                    self!.trackOneInfo[0].dataCalibration = [ProcessingDataWithBrainBit().getAnswerMindData(self?.dataDictionary ?? [:])]
                    
                } else {
                    self!.player.play()
                    self!.emotionsImpl.start()
                }
            }), for: .touchUpInside)

        }
    
    private func addTrackToMassiv() {
        if TrackMassiv().massiv[0].name == trackOneInfo[0].name {
//            TrackMassiv().massiv
        } else {
            TrackMassiv().massiv.append(trackOneInfo[0])
        }
    }
    
    //MARK: setConstrains
            
    private func setConstrains(){
        
        NSLayoutConstraint.activate([
            trackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 166),
            trackImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImage.heightAnchor.constraint(equalToConstant: 209),
            trackImage.widthAnchor.constraint(equalToConstant: 232),
            
            nameTrack.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 40),
            nameTrack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameWriter.topAnchor.constraint(equalTo: nameTrack.bottomAnchor, constant: 15),
            nameWriter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            slider.topAnchor.constraint(equalTo: nameWriter.bottomAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            currentTimeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
            currentTimeLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
            
            remainingTimeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
            remainingTimeLabel.trailingAnchor.constraint(equalTo: slider.trailingAnchor),

            buttonLeft.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 150),
            buttonLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            
            buttonPlay.centerYAnchor.constraint(equalTo: buttonLeft.centerYAnchor),
            buttonPlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            buttonRight.centerYAnchor.constraint(equalTo: buttonLeft.centerYAnchor)
            
        ])
    }
}
