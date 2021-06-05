//
//  CurtainView.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 05.06.2021.
//

import UIKit

class CurtainView: UIView {
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    private func configureUI() {
        backgroundColor = .black
    }
    
}
