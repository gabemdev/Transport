//
//  Announcement.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/22/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

enum AnnouncementCategory {
    case alert
    case promotion
    case standard
}

struct Announcement {
    var title = ""
    var summary = ""
    var date = ""
    var buttonURL = ""
    var category: AnnouncementCategory = .standard
    var image: UIImage?
}

extension Announcement {
    static let items = [promo, standard, anotherStandard, alert]
    static let promo = Announcement(title: "Total Eclipse happened today", summary: "Sky-watchers across the United States are gearing up for the best cosmic spectacle in nearly a century, when a total solar eclipse will race over the entire country for the first time since 1918. On August 21, tens of millions of lucky people will be able to watch the moon completely cover the sun and turn day into night for a few fleeting minutes.", date: "15 Aug 2017", buttonURL: "https://www.youtube.com/watch?v=1psr_moLEsI", category: .promotion, image: nil)
    static let standard = Announcement(title: "Use Promotional code to get special price today", summary: "Every large design company whether it’s a multi-national branding corporation or a regular down at heel tatty magazine publisher needs to fill holes in the workforce.", date: "14 Apr 2017", buttonURL: "http://gabemdev.com", category: .standard, image: #imageLiteral(resourceName: "Rectangle 3"))
    static let anotherStandard = Announcement(title: "Explore the city with only use the half price", summary: "Every large design company whether it’s a multi-national branding corporation or a regular down at heel tatty magazine publisher needs to fill holes in the workforce.", date: "5 Feb 2017", buttonURL: "http://twitter.com/gabemdev", category: .standard, image: #imageLiteral(resourceName: "Background2"))
    static let alert = Announcement(title: "New bug fixes", summary: "Resovled multiple bugs found in the route builder screen. Particularly when selecting multiple poi types.", date: "1 Feb 2017", buttonURL: "http://gabemdev.com", category: .alert, image: nil)
}
