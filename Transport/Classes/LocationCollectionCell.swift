//
//  LocationCollectionCell.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class LocationCollectionCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    
    
    fileprivate var delegate: Detailable?
    fileprivate var model: Announcement?
    
    func configure(with model: Announcement, delegate: Detailable) {
        self.model = model
        self.delegate = delegate
        self.dateLabel.text = model.date
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.summary
        self.locationImageView.image = model.image
    }
}

extension LocationCollectionCell {
    @IBAction func onMoreInfoButtonTapped(_ sender: UIButton) {
        self.delegate?.onCellTapped(with: self.model)
    }
}
