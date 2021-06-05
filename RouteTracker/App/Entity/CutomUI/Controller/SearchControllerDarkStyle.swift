//
//  SearchControllerDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 14.05.2021.
//

import UIKit

class SearchControllerDarkStyle: UISearchController {
    // MARK: Init
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        self.configure()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    func configure () {
        hidesNavigationBarDuringPresentation = false
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search for products"
        searchBar.searchTextField.textColor = UIColor.white
    }
}
