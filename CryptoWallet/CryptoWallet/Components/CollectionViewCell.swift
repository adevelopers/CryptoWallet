//
//  CollectionViewCell.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 22/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    var nameLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.textColor = .white
        nameLabel.alpha = 0.8
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor
            .constraint(equalTo: leftAnchor, constant: 20)
            .isActive = true
        nameLabel.centerYAnchor
            .constraint(equalTo: centerYAnchor)
            .isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String) {
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.text = name.uppercased()
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
}
