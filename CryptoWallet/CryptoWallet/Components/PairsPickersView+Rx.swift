//
//  PairsPickersView+Rx.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 22/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


extension Reactive where Base: PairsPickersView {
    var selectedPair: ControlProperty<Pair> {
        return base.rx.controlProperty(editingEvents: UIControlEvents.valueChanged, getter: { customView in
            return customView.selectedPair
        }, setter: { customView, newValue in
            customView.selectedPair = newValue
        })
    }
}
