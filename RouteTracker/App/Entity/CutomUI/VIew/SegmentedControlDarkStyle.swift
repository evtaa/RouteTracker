//
//  SegmentedControlDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class SegmentedControlDarkStyle: UISegmentedControl {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure ()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.selectedSegmentIndex = 0
        self.layer.cornerRadius = 5.0
        self.backgroundColor = .gray
        self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], for: .normal)
    }
    
}
