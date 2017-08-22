//
//  Detailable.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import Foundation
import UIKit

protocol Detailable: class {
    func onCellTapped<T>(with model: T) -> Void
}
