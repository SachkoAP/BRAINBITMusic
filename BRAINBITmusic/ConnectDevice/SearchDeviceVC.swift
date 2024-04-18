import UIKit
import neurosdk2
import EmStArtifacts

class SearchDeviceVC: UIViewController {
    
    private var scanner: NTScanner?
//    private var sensors: [NTSensorInfo] = []
    private var emotionsImpl = EmotionsImpl() // Создаем экземпляр EmotionsImpl
    var devices: [NTSensorInfo] = [NTSensorInfo]()

    private let myDeviceTitle: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Image.Device.myDeviceTitle
        return imageView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(rgb: 0x1F1F1F)
        collectionView.layer.cornerRadius = 15
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private var printTimer: Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseId)

        view.backgroundColor = .black
        
        view.addSubview(myDeviceTitle)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        setupConstraints()
        
        BrainbitController.shared.startSearch(sensorsChanged: { sensors in
            self.devices.removeAll()
            self.devices.append(contentsOf: sensors)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        })
        emotionsImpl.calibrationProgressCallback = showCalibrationProgress
        emotionsImpl.showIsArtifactedCallback = showIsArtifacted
        emotionsImpl.showLastMindDataCallback = showLastMindData

        // Запускаем кружок загрузки
        activityIndicator.startAnimating()
    }
    
    private func showCalibrationProgress(_ progress: UInt32) {
        DispatchQueue.main.async { [self] in
            print("Calibration \(String(format: "%d", progress))")
        }
    }
    private func showIsArtifacted(artifacted: Bool) {
        DispatchQueue.main.async { [self] in
            print(artifacted ? "Is Artifacted" : "Not Artifacted")
        }
    }

    private func showLastMindData(mindData: EMMindData) {
        DispatchQueue.main.async { [self] in
            print("Relaxation: \(mindData.instRelaxation) %")
            print("Attention: \(mindData.instAttention) %")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        BrainbitController.shared.stpoSearch()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myDeviceTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            myDeviceTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            myDeviceTitle.heightAnchor.constraint(equalToConstant: 25),
            myDeviceTitle.widthAnchor.constraint(equalToConstant: 177),
            
            collectionView.topAnchor.constraint(equalTo: myDeviceTitle.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 385),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// Расширения для работы с коллекцией
extension SearchDeviceVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        BrainbitController.shared.createAndConnect(sensorInfo: devices[indexPath.row], onConnectionResult: { state in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseId, for: indexPath) as! SearchCollectionViewCell
        let devInfo = devices[indexPath.row]
        cell.mainLabel.text = devInfo.name
        cell.statusLabel.text = devInfo.name != "" ? "Подключено" : "Не подключено"
        
        return cell
    }
}

extension SearchDeviceVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}