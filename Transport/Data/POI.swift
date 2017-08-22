//
//  POI.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

struct POI {
    var title = ""
    var address = ""
    var distance = ""
    var image: UIImage?
}

extension POI {
    static let items = [burgerKing, pasKal, jackAllens, gusChicken]
    static let burgerKing = POI(title: "Burger King", address: "7800 Shoal Creek Blvd", distance: "3", image: #imageLiteral(resourceName: "eat-icon"))
    static let pasKal = POI(title: "23 Paskal", address: "8715 W Highway 71", distance: "12", image: #imageLiteral(resourceName: "shop-icon"))
    static let jackAllens = POI(title: "Jack Allens", address: "3600 Capital Of Texas", distance: "8", image: #imageLiteral(resourceName: "eat-icon"))
    static let gusChicken = POI(title: "Gus's Chicken", address: "8700 South Congress", distance: "10", image: #imageLiteral(resourceName: "eat-icon"))
}
