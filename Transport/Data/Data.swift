//
//  Data.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

class Data {
    static func getAnnouncements(completion: @escaping ([Announcement]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let announcements = Announcement.items
            DispatchQueue.main.async {
                completion(announcements)
            }
        }
    }
    
    static func getPointOfInterests(completion: @escaping ([POI]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let pois = POI.items
            DispatchQueue.main.async {
                completion(pois)
            }
        }
    }
}
