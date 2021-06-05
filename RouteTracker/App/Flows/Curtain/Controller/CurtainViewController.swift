//
//  CurtainViewController.swift
//  RouteTracker
//
//  Created by Alexandr Evtodiy on 05.06.2021.
//

import UIKit

class CurtainViewController: UIViewController {
    // MARK: Properties
    var curtainView: CurtainView {
        get {
            return view as! CurtainView
        }
    }
    
    // MARK: Life cycle
    override func loadView() {
        view = CurtainView ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    
}
