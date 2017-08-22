//
//  LocationAnnouncementCell.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit


class LocationAnnouncementCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    fileprivate var delegate: Detailable?
    fileprivate var model: Announcement?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: Announcement, delegate: Detailable) {
        self.model = model
        self.delegate = delegate
        self.dateLabel.text = model.date
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.summary
        
        switch model.category {
        case .promotion:
            self.contentView.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.5215686275, blue: 1, alpha: 1)
            self.readMoreButton.backgroundColor = #colorLiteral(red: 0.4705882353, green: 0.5490196078, blue: 0.968627451, alpha: 1)
        case .standard:
            self.contentView.backgroundColor = .white
        case .alert:
            self.contentView.backgroundColor = #colorLiteral(red: 0.9449093938, green: 0.537754178, blue: 0.5443484187, alpha: 1)
            self.readMoreButton.backgroundColor = #colorLiteral(red: 0.9440491796, green: 0.5268895626, blue: 0.5322791338, alpha: 1)
        }
    }
}

extension LocationAnnouncementCell {
    @IBAction func onMoreInfoButtonTapped(_ sender: UIButton) {
        self.delegate?.onCellTapped(with: self.model)
    }
}
