//
//  MenuLauncher.swift
//  RecycleMe
//
//  Created by Tyler Phillips on 7/17/18.
//  Copyright © 2018 Tyler Phillips. All rights reserved.
//

import Foundation
import UIKit

//Class that states the array below
class AppMenu: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}

class MenuLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let blackView = UIView()
    
    //The collectionView that slides up from the bottom
    let menuView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor(red: 161.0/255.0, green: 252.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 10
        cv.layer.borderWidth = 1.0
        cv.layer.borderColor = UIColor.clear.cgColor
        cv.layer.masksToBounds = true
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    //Array for the bottom slide up menu
    let menus: [AppMenu] = {
        return [AppMenu(name: "Add a Store/Business", imageName: "home"),
                AppMenu(name: "Notifications", imageName: "messages"),
                AppMenu(name: "Settings", imageName: "class"),
                AppMenu(name: "About PayMap", imageName: "sign-out")]
    }()
    
    //Bottom slide up menu function
    func showMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(menuView)
            
            let height: CGFloat = 300
            let y = window.frame.height - height
            menuView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.menuView.frame = CGRect(x: 0, y: y, width: self.menuView.frame.width , height: self.menuView.frame.height)
            }, completion: nil)
            
        }
        
    }
    
    //Function that handles dismissal with a Gesture Recognizer
    @objc func handleDismiss(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.menuView.frame = CGRect(x: 0, y: window.frame.height, width: self.menuView.frame.width, height: window.frame.height)
            }
        })
    }
    
    //Number of cells within slide up menu -- depends on number of cells in the array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    //Cell dequeue for 'Menu' cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuLauncherCell
        
        let menu = menus[indexPath.item]
        cell.menu = menu
        return cell
    }
    
    //CollectionView CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuView.frame.width, height: cellHeight)
    }
    
    //Line spacing between each array cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //Function that dismisses the menu when a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.blackView.alpha = 0
        
        if let window = UIApplication.shared.keyWindow {
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: collectionView.frame.width, height: collectionView.frame.height)
        }
    
        //Handle Dismissal of the slide menu
        self.handleDismiss()
    }
    
    override init() {
        super.init()
        menuView.dataSource = self
        menuView.delegate = self
        menuView.register(MenuLauncherCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
