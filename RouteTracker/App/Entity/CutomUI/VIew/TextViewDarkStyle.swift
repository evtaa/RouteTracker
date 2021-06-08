//
//  TextViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 13.05.2021.
//

import UIKit

class TextViewDarkStyle: UITextView {
    // MARK: Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Cinfigure
    private func configure() {
        self.backgroundColor = .black
    }
}
