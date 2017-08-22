//
//  UIStoryboard+Helper.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/19/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main
    case Location
    case RouteBuilder
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("Viewcontroller with ID \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        
        return scene
    }
}


extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard : AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

