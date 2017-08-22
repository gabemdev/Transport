//
//  POITypeHeaderView.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

protocol POITypeDelegate {
    func didSelectPOIType()
}

class POITypeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var items: [UIImage] = [#imageLiteral(resourceName: "user-icon"), #imageLiteral(resourceName: "favorit-icon"), #imageLiteral(resourceName: "terminal-icon"), #imageLiteral(resourceName: "shop-icon"), #imageLiteral(resourceName: "eat-icon")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let filterType = UINib(nibName: String(describing: POITypeCell.self), bundle: nil)
        self.collectionView.register(filterType, forCellWithReuseIdentifier: String(describing: POITypeCell.self))
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDelegate
extension POITypeHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let index = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: index) as? POITypeCell else { return }
            cell.cellButton.tintColor = .red
    }
}

// MARK: - UICollectionViewDataSource
extension POITypeHeaderView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: POITypeCell.self), for: indexPath) as! POITypeCell
        let image = self.items[indexPath.row]
        cell.configure(with: image)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension POITypeHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.contentView.bounds.width / CGFloat(items.count)
        let height: CGFloat = 54
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
