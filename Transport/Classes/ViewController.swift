//
//  ViewController.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/18/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var newsBarButtonItem: UIBarButtonItem!
    
    let regionRadius : CLLocationDistance = 1000
    let coordinate = CLLocationCoordinate2D(latitude: 29.7589, longitude: -95.3677) // Default to Houston, TX downtown.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        customTabBar.items = [#imageLiteral(resourceName: "bike-icon"), #imageLiteral(resourceName: "hitch-icon"), #imageLiteral(resourceName: "rental-icon"), #imageLiteral(resourceName: "car-icon")]
        newsBarButtonItem.addBadge(andColor: #colorLiteral(red: 1, green: 0.4862745098, blue: 0.4862745098, alpha: 1))
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Initial Setup
extension ViewController {
    func configureViews() {
        let mapIcon = UIImageView(image: #imageLiteral(resourceName: "mapmarker-icon"))
        if let size = mapIcon.image?.size {
            mapIcon.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 20.0, height: size.height)
        }
        mapIcon.contentMode = .center
        mapIcon.isAccessibilityElement = false
        searchBar.leftViewMode = .always
        searchBar.leftView = mapIcon
        searchBar.delegate = self
        
        centerMapOnLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
    }
    
    
    /// Center map on a coordinate
    ///
    /// - Parameter location: CLLocation with latitude and longitude
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - Actions and Segues
extension ViewController {
    @IBAction func onCenterButtonTapped(_ sender: FloatingActionButton) {
        
    }
    
    @IBAction func onNewsButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: String(describing: LocationViewController.self), sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == String(describing: LocationViewController.self), let destination = segue.destination as? LocationViewController {
            destination.delegate = self
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchBar {
            searchBar.resignFirstResponder()
            let vc = RouteBuilderViewController.instantiate(fromAppStoryboard: .RouteBuilder)
            vc.delegate = self
            present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - ModalTransitionDelegate
extension ViewController: ModalTransitionDelegate {
    func updateStatusBarStyle() {
        UIApplication.shared.statusBarStyle = .lightContent
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
