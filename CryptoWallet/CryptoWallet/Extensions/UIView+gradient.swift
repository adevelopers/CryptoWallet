//
//  UIView+gradient.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import UIKit


extension UIView {
    
    @discardableResult
    func addGradient(cgColors: [CGColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = cgColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
    
}
