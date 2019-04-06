//
//  MenuLauncherCell.swift
//  RecycleMe
//
//  Created by Tyler Phillips on 7/17/18.
//  Copyright © 2018 Tyler Phillips. All rights reserved.
//

import Foundation
import UIKit

class MenuLauncherCell: BaseCell {
    
    //    This shows action when a menu setting is tapped( NOT WORKING PROPERLY )
    override var isHighlighted: Bool {
        didSet {
            
//            backgroundColor = isHighlighted ? UIColor(red: 157/255, green: 215/255, blue: 214/255, alpha: 1) : UIColor.white
            
//            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            print(isHighlighted)
        }
    }
    
    var menu: AppMenu? {
        didSet {
            nameLabel.text = menu?.name
            if let imageName = menu?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Menu"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "macbook")
        image.contentMode = .scaleToFill
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        //Adjust the distance from the top of the screen for iconImageView and nameLabel
        
        addConstraintWithFormat(format: "H:|-20-[v0(30)]-20-[v1]|", view: iconImageView, nameLabel)
        addConstraintWithFormat(format: "V:|[v0]|", view: nameLabel)
        addConstraintWithFormat(format: "V:[v0(30)]", view: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 65))
        //        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 60))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension UIView {
    func addConstraintWithFormat(format: String, view: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in view.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
