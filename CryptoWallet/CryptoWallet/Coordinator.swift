//
//  Coordinator.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit


class Coordinator {
    var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func presentViewController() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(ViewController(), animated: true)
    }
}
