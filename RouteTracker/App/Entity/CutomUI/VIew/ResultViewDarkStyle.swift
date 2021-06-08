//
//  ResultViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class ResultViewDarkStyle: UIView {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.backgroundColor = .black
        self.isHidden = true
    }
}
