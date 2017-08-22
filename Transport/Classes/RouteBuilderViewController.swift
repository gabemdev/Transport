//
//  RouteBuilderViewController.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/21/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit

enum HeaderSizes: CGFloat {
    case routeHeader = 54.0
    case standard = 12.0
}

class RouteBuilderViewController: UIViewController {
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [POI] = []
    
    weak var delegate: ModalTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        Data.getPointOfInterests { (pois) in
            self.tableData = pois
            self.tableView.reloadData()
        }
        
        let header = UINib(nibName: String(describing: POITypeHeaderView.self), bundle: nil)
        self.tableView.register(header, forHeaderFooterViewReuseIdentifier: String(describing: POITypeHeaderView.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - UITableViewDataSource
extension RouteBuilderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: POITableViewCell.self), for: indexPath) as! POITableViewCell
        let poi = self.tableData[indexPath.section]
        cell.configure(with: poi)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RouteBuilderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: POITypeHeaderView.self)) as! POITypeHeaderView
            return cell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return HeaderSizes.routeHeader.rawValue
        default:
            return HeaderSizes.standard.rawValue
        }
    }
}

// MARK: - IBActions and Segues
extension RouteBuilderViewController {
    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.delegate?.updateStatusBarStyle()
    }
}
