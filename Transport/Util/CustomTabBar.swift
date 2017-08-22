//
//  CustomTabBar.swift
//  MappingGabe
//
//  Created by Gabriel Morales on 8/18/17.
//  Copyright © 2017 Phunware. All rights reserved.
//

import UIKit


@IBDesignable
class CustomTabBar: UIControl {
    
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedTabIndex = 0
    
    
    var items: [UIImage] = [CustomTabBar.getDefaultImage()] {
        didSet {
            updateViews()
        }
    }
    
    @IBInspectable
    var inactiveColor: UIColor = UIColor.lightGray {
        didSet {
            updateViews()
        }
    }
    
    
    @IBInspectable
    var selectorTintColor: UIColor = .lightGray {
        didSet {
            updateViews()
        }
    }
    
    @IBInspectable
    var selectedTintColor: UIColor = .lightGray {
        didSet {
            updateViews()
        }
    }
    
    @IBInspectable
    var selectorWidth: CGFloat = 40 {
        didSet {
            updateViews()
        }
    }

    
    override func draw(_ rect: CGRect) {
        updateViews()
    }

}

fileprivate extension CustomTabBar {
    func updateViews() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        for image in items {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            button.setImage(image, for: .normal)
            button.tintColor = inactiveColor
            button.addTarget(self, action: #selector(onTabItemSelected(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].tintColor = selectedTintColor
        
        let origin: CGFloat = bounds.width / CGFloat(items.count) / 2 - (selectorWidth / 2)
        selector = UIView(frame: CGRect(x: origin, y: frame.height - 10, width: selectorWidth, height: 2))
        selector.backgroundColor = selectorTintColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        clipsToBounds = true
    }
    
    @objc func onTabItemSelected(button: UIButton) {
        for (btnIndex, btn) in buttons.enumerated() {
            btn.tintColor = inactiveColor
            
            if btn == button {
                selectedTabIndex = btnIndex
//                let start: CGFloat = frame.width / CGFloat(buttons.count) * CGFloat(btnIndex)
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                    self.selector.center.x = btn.center.x
                })
                btn.tintColor = selectedTintColor
            }
        }
        sendActions(for: .valueChanged)
    }
    
    class func getDefaultImage()->UIImage{
        if let defaultImage = UIImage(named: "bike-icon"){
            return defaultImage
        }else{
            return UIImage()
        }
    }
}
