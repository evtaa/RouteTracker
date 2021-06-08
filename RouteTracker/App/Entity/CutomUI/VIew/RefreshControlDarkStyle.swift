//
//  RefreshControlDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class RefreshControlDarkStyle: UIRefreshControl {
    // MARK: Init
    override init() {
        super.init()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.tintColor = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 0.7)
    }
}
