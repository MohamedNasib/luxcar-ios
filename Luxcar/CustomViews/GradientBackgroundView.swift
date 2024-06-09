//
//  GradientBackgroundView.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 02/10/2023.
//

import UIKit

class GradientBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        self.alpha = 0.7
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        
        gradientLayer.locations = [0, 0.27]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5 * self.bounds.size.width, dy: -0.5 * self.bounds.size.height)
        gradientLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        self.layer.addSublayer(gradientLayer)
    }

}

