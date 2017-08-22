//
//  LocationViewController.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/19/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

enum LocationRows: Int {
    case announcement
    case standard
    case alert
    
    func cellID() -> String {
        switch self {
        case .announcement, .alert: return String(describing: LocationAnnouncementCell.self)
        case .standard: return String(describing: LocationCollectionCell.self)
        }
    }
}

enum ItemSizes: CGFloat {
    case announcement = 264.0
    case standard = 464.0
}

class LocationViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionTypes: [LocationRows] = [.announcement, .standard, .alert]
    
    var annoncementItems: [Announcement] = []
    var items: [Announcement] = []
    var alerts: [Announcement] = []
    
    weak var delegate: ModalTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        Data.getAnnouncements { (items) in
            self.items = items.filter { $0.category == AnnouncementCategory.standard }
            self.annoncementItems = items.filter { $0.category == AnnouncementCategory.promotion }
            self.alerts = items.filter { $0.category == AnnouncementCategory.alert }
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - UICollectionViewDataSource
extension LocationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section: LocationRows = self.sectionTypes[section]
        switch section {
        case .announcement:
            return annoncementItems.count
        case .standard:
            return items.count
        case .alert:
            return alerts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section: LocationRows = self.sectionTypes[indexPath.section]
        switch section {
        case .announcement: return announcementCell(section, indexPath)
        case .standard: return mainCell(section, indexPath)
        case .alert: return alertCell(section, indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LocationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section: LocationRows = self.sectionTypes[indexPath.section]
        
        let width: CGFloat = self.view.bounds.size.width - 40
        var height: CGFloat = 0
        
        switch section {
        case .announcement, .alert:
            height = ItemSizes.announcement.rawValue
        case .standard:
            height = ItemSizes.standard.rawValue
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section: LocationRows = self.sectionTypes[section]
        switch section {
        case .announcement, .alert:
            return .zero
        case .standard:
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LocationViewController {
    func announcementCell(_ section: LocationRows, _ indexPath: IndexPath) -> LocationAnnouncementCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationRows.announcement.cellID(), for: indexPath) as! LocationAnnouncementCell
        let announcement = self.annoncementItems[indexPath.row]
        cell.configure(with: announcement, delegate: self)
        return cell
    }
    
    func mainCell(_ section: LocationRows, _ indexPath: IndexPath) -> LocationCollectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationRows.standard.cellID(), for: indexPath) as! LocationCollectionCell
        let item = self.items[indexPath.row]
        cell.configure(with: item, delegate: self)
        return cell
    }
    
    func alertCell(_ section: LocationRows, _ indexPath: IndexPath) -> LocationAnnouncementCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationRows.alert.cellID(), for: indexPath) as! LocationAnnouncementCell
        let alert = self.alerts[indexPath.row]
        cell.configure(with: alert, delegate: self)
        return cell
    }
    
    func registerCells() {
        let announcement = UINib(nibName: String(describing: LocationAnnouncementCell.self), bundle: nil)
        self.collectionView.register(announcement, forCellWithReuseIdentifier: LocationRows.announcement.cellID())
        
        let standard = UINib(nibName: String(describing: LocationCollectionCell.self), bundle: nil)
        self.collectionView.register(standard, forCellWithReuseIdentifier: LocationRows.standard.cellID())
        
        let alert = UINib(nibName: String(describing: LocationAnnouncementCell.self), bundle: nil)
        self.collectionView.register(alert, forCellWithReuseIdentifier: LocationRows.alert.cellID())
    }
}


// MARK: - Detailable
extension LocationViewController: Detailable {
    func onCellTapped<T>(with model: T) {
        switch model {
        case let annnouncement as Announcement:
            print(annnouncement.buttonURL)
        default:
            print("NIL")
        }
    }
    
    @IBAction func onDimissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.delegate?.updateStatusBarStyle()
    }
}
