//
//  CardViewController.swift
//  Pay?
//
//  Created by Tyler P Admin on 5/18/19.
//  Copyright © 2019 Tyler P Admin. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var swiper: UIView!
    
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var genresLabelLeadingConstraint: NSLayoutConstraint!
    
    
    var cells = [MenuLabelCell]()
    
    let genres = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleArea.backgroundColor = .red
        
//        swiper.backgroundColor = UIColor(r: 180, g: 182, b: 184, a: 0.6)
        swiper.backgroundColor = .white
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: collectionViewFlowLayout)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 30
        }
        
        collectionView.register(MenuLabelCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.backgroundColor = .groupTableViewBackground
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let cardWidth = self.view.frame.width * 0.375
        let contentInsets = (self.view.frame.width - (cardWidth * 2)) / 3
        print("ContentInsets: \(contentInsets)")
        
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: contentInsets, bottom: 8, right: contentInsets)
//        genresLabel.textColor = UIColor(r: 180, g: 182, b: 184, a: 1)
        genresLabel.textColor = .white
        genresLabelLeadingConstraint.constant = contentInsets
        
        
        contentView.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    
    func setupCollectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    
}



extension CardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuLabelCell
        
        cell.label.text = genres[indexPath.row]
        
        cells.append(cell)
        
        return cell
        
    }
    
    
    
}

extension CardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        cells.forEach { $0.isHighlighted = false }
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2) {
            cell?.isHighlighted = true
            
        }
    }
    
}

extension CardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cardWidth = self.view.frame.width * 0.375
        return CGSize(width: cardWidth, height: cardWidth / 3)
    }
}

