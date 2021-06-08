//
//  ActivityIndicatorDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 08.05.2021.
//

import UIKit

class ActivityIndicatorDarkStyle: UIActivityIndicatorView {
    // MARK: Init
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.style = .large
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        self.transform = CGAffineTransform(scaleX: 1, y: 1);
        self.color = UIColor(red: 0.25, green: 0.72, blue: 0.85, alpha: 0.7)
    }

}
