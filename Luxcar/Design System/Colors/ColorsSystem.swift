//
//  ColorsSystem.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 20/09/2023.
//

import UIKit

enum AppColorSystem {
    case white
    case black
    case darkText
    case primary
    case secondary
    case LightGrey
    case Border
    case inActiveButton
    case titleGray
    case descGray
    case buttonTitle
    case textViewColor
    case otpBG
    
    var color : UIColor {
        switch self {
        case .white:
            return getColorByName(colorName: "white")
        case .black:
            return getColorByName(colorName: "black")
        case .darkText:
            return getColorByName(colorName: "Dark Text")
        case .primary:
            return getColorByName(colorName: "Primary")
        case .secondary:
            return getColorByName(colorName: "Secondary")
        case .LightGrey:
            return getColorByName(colorName: "LightGrey")
        case .Border:
            return getColorByName(colorName: "Border")
        case .inActiveButton:
            return getColorByName(colorName: "InActiveButton")
        case .titleGray:
            return getColorByName(colorName: "FieldsGray")
        case .descGray:
            return getColorByName(colorName: "DescGray")
        case .buttonTitle:
            return getColorByName(colorName: "ButtonTitle")
        case .textViewColor:
            return getColorByName(colorName: "textViewColor")
        case .otpBG:
            return getColorByName(colorName: "OTPBG")
        }
    }
    
    var layerColor : CGColor {
        return self.color.cgColor
    }
    
    private func getColorByName(colorName : String) -> UIColor {
        return UIColor.init(named: colorName)!
    }
}
