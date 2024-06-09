//
//  HeaderView+BackButton.swift
//  Luxcar
//
//  Created by Ahmed El-elaimy on 02/10/2023.
//

import UIKit

class HeaderView_BackButton: UIView {

    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var backButton: UIButton!

    
    @IBInspectable var titleText: String? {
        get {
            return title.text
        }
        set {
            title.text = newValue
        }
    }
    
    @IBInspectable var backButtonHidden: Bool {
        get {
            return backButton.isHidden
        }
        set {
            backButton.isHidden = newValue
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Load the XIB file and add it as a subview
        let nib = UINib(nibName: "HeaderView+BackButton", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    @IBAction func back(_ sender: UIButton){
        self.iq.parentContainerViewController()?.dismiss(animated: true)
    }

}
