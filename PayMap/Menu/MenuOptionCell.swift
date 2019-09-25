//
//  MenuOptionCell.swift
//  Pay?
//
//  Created by Tyler P Admin on 5/18/19.
//  Copyright © 2019 Tyler P Admin. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class MenuLabelCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? .white : .darkGray
            
            label.backgroundColor = isHighlighted ? UIColor(r: 70, g: 136, b: 241, a: 1) : UIColor(r: 180, g: 182, b: 184, a: 0.3)
            
            
            //shadow
        }
    }
    
    
    let label: UILabel = {
        let lbl = UILabel()
        
        
        lbl.backgroundColor = UIColor(r: 180, g: 182, b: 184, a: 0.3)
        lbl.textColor = .darkGray
        lbl.backgroundColor?.withAlphaComponent(0.3)
        
        
        lbl.textAlignment = .center
        lbl.text = "Menu"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isUserInteractionEnabled = true
        
        lbl.layer.cornerRadius = 8
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    override func setupViews() {
        addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
}



extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        let r = r / 255
        let g = g / 255
        let b = b / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}
