//
//  POITableViewCell.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class POITableViewCell: UITableViewCell {
    
    @IBOutlet weak var poiImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var poiTitleLabel: UILabel!
    @IBOutlet weak var poiAddressLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override open var isSelected: Bool {
        didSet {
            favorite(self.isSelected)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.favoriteButton.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }

    func configure(with poi: POI) {
        self.poiImageView.image = poi.image
        self.poiTitleLabel.text = poi.title
        self.poiAddressLabel.text = poi.address
        self.distanceLabel.text = poi.distance + " Mi"
        self.favoriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
    }

}

extension POITableViewCell {
    func toggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        favorite(sender.isSelected)
        
    }
    
    fileprivate func favorite(_ isSelected: Bool) {
        self.favoriteButton.setImage(isSelected ? #imageLiteral(resourceName: "star-selected") : #imageLiteral(resourceName: "star"), for: .normal)
    }
}
