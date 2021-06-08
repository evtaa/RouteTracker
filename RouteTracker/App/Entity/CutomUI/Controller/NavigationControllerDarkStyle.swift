//
//  NavigationControllerDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 08.05.2021.
//

import UIKit

class NavigationControllerDarkStyle: UINavigationController {
    // MARK: Init
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.configure ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Configure
    private func configure () {
        navigationBar.backgroundColor = .black
        navigationBar.barTintColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
