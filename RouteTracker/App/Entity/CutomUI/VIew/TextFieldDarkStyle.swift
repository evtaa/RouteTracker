//
//  AccountPropertyTextField.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class TextFieldDarkStyle: UITextField {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cinfigure
    private func configure() {
        self.adjustsFontSizeToFitWidth = true
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.backgroundColor = .black
        self.textColor = .white
        self.textAlignment = .left
        self.attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.font = UIFont.systemFont(ofSize: 18.0)
    }
}
