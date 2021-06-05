//
//  SimpleButton.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class ButtonDarkStyle: UIButton {
    // MARL: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.setTitle("Button", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.setTitleShadowColor(.gray, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.backgroundColor = .black
    }
}
