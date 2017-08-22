//
//  POITypeCell.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class POITypeCell: UICollectionViewCell {
    
    @IBOutlet weak var cellButton: UIButton!
    
    override open var isSelected: Bool {
        didSet {
            filterCategory(self.isSelected, sender: self.cellButton)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellButton.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }
    
    func configure(with image: UIImage) {
        self.cellButton.setImage(image, for: .normal)
    }
    
}

extension POITypeCell {
    func toggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        filterCategory(sender.isSelected, sender: sender)
    }
    
    fileprivate func filterCategory(_ isSelected: Bool, sender: UIButton) {
        sender.backgroundColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.968627451, alpha: 1)
        switch sender {
        case let person where sender.imageView?.image == #imageLiteral(resourceName: "user-icon") || sender.imageView?.image == #imageLiteral(resourceName: "user-icon-selected"):
            person.setImage(isSelected ?#imageLiteral(resourceName: "user-icon-selected") : #imageLiteral(resourceName: "user-icon"), for: .normal)
        case let favorites where sender.imageView?.image == #imageLiteral(resourceName: "favorit-icon") || sender.imageView?.image == #imageLiteral(resourceName: "favorit-icon-selected"):
            favorites.setImage(isSelected ? #imageLiteral(resourceName: "favorit-icon-selected") : #imageLiteral(resourceName: "favorit-icon"), for: .normal)
        case let bus where sender.imageView?.image == #imageLiteral(resourceName: "terminal-icon") || sender.imageView?.image == #imageLiteral(resourceName: "terminal-icon-selected"):
            bus.setImage(isSelected ? #imageLiteral(resourceName: "terminal-icon-selected") : #imageLiteral(resourceName: "terminal-icon"), for: .normal)
        case let store where sender.imageView?.image == #imageLiteral(resourceName: "shop-icon") || sender.imageView?.image == #imageLiteral(resourceName: "shop-icon-selected"):
            store.setImage(isSelected ? #imageLiteral(resourceName: "shop-icon-selected") : #imageLiteral(resourceName: "shop-icon"), for: .normal)
        case let dining where sender.imageView?.image == #imageLiteral(resourceName: "eat-icon") || sender.imageView?.image == #imageLiteral(resourceName: "eat-icon-selected"):
            dining.setImage(isSelected ? #imageLiteral(resourceName: "eat-icon-selected") : #imageLiteral(resourceName: "eat-icon"), for: .normal)
        default:
            print("NIL")
        }
    }
}

