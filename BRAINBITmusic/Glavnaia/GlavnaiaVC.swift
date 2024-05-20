import Foundation
import UIKit
import neurosdk2

class GlavnaiaVC : UIViewController, ConnectionObserver {
    
    private var cellsService : [ServiceCollection] = []
    private var cellsCollection: [CollectionCollection] = []
    weak var connectionObserver: ConnectionObserver?

    private let photoNoRegUser: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = Image.Glavnaia.photoNoRegUser
        button.setImage(image, for: .normal)
        return button
    }()
    private let nameUser: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Guest", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let wheareListen: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = Image.Glavnaia.wheareListen
        return image
    }()

    private lazy var collectionViewService: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let ourSelection: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = Image.Glavnaia.ourSelection
        return image
    }()
    
    private let backGroundNotConnectedDevice: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = Image.Glavnaia.backGroundNotConnectedDevice
        return image
    }()
    private let titleOnBackGroundNotConnectedDevice: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        text.textColor = .white
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.text = "Нет соединения с устройством"
        return text
    }()

    private lazy var collectionViewCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        self.connectionObserver = self

        //service
        collectionViewService.register(ServiceCollcectionViewCell.self, forCellWithReuseIdentifier: ServiceCollcectionViewCell.reuseId)
        collectionViewService.dataSource = self
        
        let flowLayoutService = UICollectionViewFlowLayout()
        flowLayoutService.scrollDirection = .horizontal
        collectionViewService.collectionViewLayout = flowLayoutService
        collectionViewService.delegate = self
        collectionViewService.showsVerticalScrollIndicator = false
        collectionViewService.showsHorizontalScrollIndicator = false
        collectionViewService.backgroundColor = .clear
        
        cellsService = [ServiceCollection(id: 0, image: Image.Glavnaia.imageYandexCVC!), ServiceCollection(id: 1, image: Image.Glavnaia.iamgeVKCVC!), ServiceCollection(id: 2, image: Image.Glavnaia.imageSpotifyCVC!), ServiceCollection(id: 3, image: Image.Glavnaia.imageAppleMusicCVC!)]
        
        //collection
        collectionViewCollection.register(CollectionCollectionViewCell.self, forCellWithReuseIdentifier: CollectionCollectionViewCell.reuseId)
        collectionViewCollection.dataSource = self
        
        let flowLayoutCollection = UICollectionViewFlowLayout()
        flowLayoutCollection.scrollDirection = .horizontal
        collectionViewCollection.collectionViewLayout = flowLayoutCollection
        collectionViewCollection.delegate = self
        collectionViewCollection.showsVerticalScrollIndicator = false
        collectionViewCollection.showsHorizontalScrollIndicator = false
        collectionViewCollection.backgroundColor = .clear
        
        cellsCollection = [CollectionCollection(id: 0, image: Image.Glavnaia.imageRelaxCVC!, listTracks: [TrackInfo(image: Image.Player.imageFromTrack!, name: "Arcade", nameWriter: "Dumcan Laurence", dataCalibration: [0.0]), TrackInfo(image: Image.Player.imageFromTrack2!, name: "Save Your Tears", nameWriter: "The Weekend", dataCalibration: [0.0])]), CollectionCollection(id: 1, image: Image.Glavnaia.imageSleepCVC!, listTracks: [TrackInfo(image: Image.Player.imageFromTrack!, name: "Arcade", nameWriter: "Dumcan Laurence", dataCalibration: [0.0])]), CollectionCollection(id: 2, image: Image.Glavnaia.imageWorkCVC!, listTracks: [TrackInfo(image: Image.Player.imageFromTrack!, name: "Arcade", nameWriter: "Dumcan Laurence", dataCalibration: [0.0])])]
        
        view.addSubview(photoNoRegUser)
        view.addSubview(nameUser)
        view.addSubview(wheareListen)
        view.addSubview(collectionViewService)
        view.addSubview(ourSelection)
        view.addSubview(collectionViewCollection)
        view.addSubview(backGroundNotConnectedDevice)
        
        // Установка начальной позиции за кадром
        backGroundNotConnectedDevice.frame.origin.y = -backGroundNotConnectedDevice.frame.height
        
        // Устанавливаем начальное положение за пределами экрана
        let deviceHeight = UIScreen.main.bounds.height
        let windowHeight: CGFloat  = 50 // Высота окна (вы можете изменить это на ваше усмотрение)
        let windowYPosition = -deviceHeight + windowHeight // Устанавливаем начальное положение по Y

        backGroundNotConnectedDevice.frame = CGRect(x: 0, y: -deviceHeight, width: view.frame.width, height: 100)
        
        // Добавляем titleOnBackGroundNotConnectedDevice и настраиваем его
        backGroundNotConnectedDevice.addSubview(titleOnBackGroundNotConnectedDevice)
        titleOnBackGroundNotConnectedDevice.centerXAnchor.constraint(equalTo: backGroundNotConnectedDevice.centerXAnchor).isActive = true
        titleOnBackGroundNotConnectedDevice.bottomAnchor.constraint(equalTo: backGroundNotConnectedDevice.bottomAnchor, constant: -15).isActive = true

        // Добавляем жест для скрытия окна свайпом вверх
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        backGroundNotConnectedDevice.addGestureRecognizer(swipeGesture)
        backGroundNotConnectedDevice.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        backGroundNotConnectedDevice.isUserInteractionEnabled = true
        backGroundNotConnectedDevice.addGestureRecognizer(tapGesture)


        showWindow()
        addActions()
        setupConstraint()
        setupTabbarItem()
    }
    
    private func setupTabbarItem() {
        tabBarItem = UITabBarItem(
            title: "",
            image: Image.Glavnaia.glavnaiaTabBarImage,
            tag: 1
        )
    }

    
    func deviceConnected() {
        print("Yep!")
        hideWindow()
    }

    
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let vc = SearchDeviceVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func addActions() {
        photoNoRegUser.addAction(UIAction(handler: { [weak self] _ in
            let vc = Vhod()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        nameUser.addAction(UIAction(handler: { [weak self] _ in
            let vc = Vhod()
            self?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            photoNoRegUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
            photoNoRegUser.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            photoNoRegUser.heightAnchor.constraint(equalToConstant: 41),
            photoNoRegUser.widthAnchor.constraint(equalToConstant: 41),
            
            nameUser.centerYAnchor.constraint(equalTo: photoNoRegUser.centerYAnchor),
            nameUser.leadingAnchor.constraint(equalTo: photoNoRegUser.trailingAnchor, constant: 20),
                        
            wheareListen.topAnchor.constraint(equalTo: photoNoRegUser.bottomAnchor, constant: 34),
            wheareListen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            
            collectionViewService.topAnchor.constraint(equalTo: wheareListen.bottomAnchor, constant: 20),
            collectionViewService.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionViewService.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionViewService.heightAnchor.constraint(equalToConstant: 173),//
            
            ourSelection.topAnchor.constraint(equalTo: collectionViewService.bottomAnchor, constant: 40),
            ourSelection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            
            collectionViewCollection.topAnchor.constraint(equalTo: ourSelection.bottomAnchor, constant: 20),
            collectionViewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionViewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            collectionViewCollection.heightAnchor.constraint(equalToConstant: 210),//
        ])
    }
    
    @objc func handleSwipeGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        switch gesture.state {
        case .changed:
            backGroundNotConnectedDevice.frame.origin.y += translation.y
            gesture.setTranslation(.zero, in: self.view)
        case .ended:
            if velocity.y < -500 || backGroundNotConnectedDevice.frame.origin.y > UIScreen.main.bounds.height / 2 {
                hideWindow()
            } else {
                showWindow()
            }
        default:
            break
        }
    }

    func hideWindow() {
        UIView.animate(withDuration: 0.5) {
            self.backGroundNotConnectedDevice.frame.origin.y = -UIScreen.main.bounds.height
        }
    }

    func showWindow() {
        UIView.animate(withDuration: 0.5) {
            self.backGroundNotConnectedDevice.frame.origin.y = 0
        }
    }
}

extension GlavnaiaVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewService {
            return cellsService.count
        } else if collectionView == self.collectionViewCollection {
            return cellsCollection.count
        }
        return 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewService {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollcectionViewCell.reuseId, for: indexPath) as! ServiceCollcectionViewCell
            cell.mainImageView.image = cellsService[indexPath.row].image
            return cell
        } else if collectionView == self.collectionViewCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCollectionViewCell.reuseId, for: indexPath) as! CollectionCollectionViewCell
            cell.mainImageView.image = cellsCollection[indexPath.row].image
            return cell
        }
        return UICollectionViewCell()
    }
}

extension GlavnaiaVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewService {
            return CGSize(width: 165, height: 172)
        } else if collectionView == self.collectionViewCollection {
            return CGSize(width: 232, height: 209)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}

extension GlavnaiaVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewService {
//            let vc = Vhod()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)

        } else if collectionView == self.collectionViewCollection {
//            let vc = Player()
////            vc.trackOneInfo = cellsCollection[indexPath.row]
//            vc.trackOneInfo = [TrackInfo(image: Image.Player.imageFromTrack!, name: "Arcade", nameWriter: "Dumcan Laurence", dataCalibration: [0.0])]
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
            
            let vc = PlaylistVC(playlistInfo: cellsCollection[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)

        }
    }
}

protocol ConnectionObserver: AnyObject {
    func deviceConnected()
}

//расширение библиотеки с цветом для облегчения его указания
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
