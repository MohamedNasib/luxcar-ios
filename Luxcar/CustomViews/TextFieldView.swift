//
//  TextFieldView.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit

class TextFieldView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // Method to set up the view
    private func configure() {
        self.backgroundColor = UIColor(red: 0.808, green: 0.808, blue: 0.808, alpha: 0.2)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}

