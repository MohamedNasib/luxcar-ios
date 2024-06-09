//
//  MainButton.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 18/09/2023.
//

import UIKit

import UIKit

@IBDesignable
class MainButton: UIButton {
    
    // Make the properties inspectable in Interface Builder
    @IBInspectable var backgroundColorForNormal: UIColor? {
        didSet {
            configureButton()
        }
    }
    
    @IBInspectable var fontColorForNormal: UIColor? {
        didSet {
            configureButton()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            configureButton()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            configureButton()
        }
    }
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    // Function to set up button appearance
    private func configureButton() {
        self.setTitleColor(fontColorForNormal ?? .white, for: .normal)
        self.backgroundColor = backgroundColorForNormal ?? .blue
        self.layer.cornerRadius = 5
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        
        // Set the font to "Poppins-Bold" with a size of 16
        self.titleLabel?.font = AppFontSystem.bold.size(16)
    }
    
    // Update in Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureButton()
    }
}


