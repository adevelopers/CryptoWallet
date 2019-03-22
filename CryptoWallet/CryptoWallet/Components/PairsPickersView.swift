//
//  PairsPickersView.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 22/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class PairsPickersView: UIControl {
    
    let bag = DisposeBag()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var collectionViewLayout: UICollectionViewFlowLayout!
    
    var selectedPair: Pair = Pair(from: "ETH", to: "USD") {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    var viewModel = CryptoListViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.backgroundColor = .clear
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 250, height: 50)
        
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        viewModel.items.bind(to: collectionView.rx.items(cellIdentifier: "defaultCell", cellType: CollectionViewCell.self)) {
            [weak self] row, model, cell in
                if let gradientColors = self?.viewModel.gradientColors[model.from] {
                    cell.addGradient(cgColors: gradientColors)
                    cell.configure(name: model.from)
                }
            
            }.disposed(by: bag)
        
        collectionView.rx.modelSelected(Pair.self).subscribe(onNext: {
            [weak self] in
                self?.selectedPair = $0
            })
            .disposed(by: bag)
        
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor
            .constraint(equalTo: topAnchor, constant: 0)
            .isActive = true
        collectionView.widthAnchor
            .constraint(equalTo: widthAnchor, constant: -40)
            .isActive = true
        collectionView.centerXAnchor
            .constraint(equalTo: centerXAnchor)
            .isActive = true
        collectionView.heightAnchor
            .constraint(equalToConstant: 300)
            .isActive = true
    }
}

