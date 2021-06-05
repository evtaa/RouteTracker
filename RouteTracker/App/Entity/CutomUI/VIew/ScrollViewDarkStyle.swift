//
//  ScrollViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import UIKit

class ScrollViewDarkStyle: UIScrollView {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure() {

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
}
