//
//  TableViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 07.05.2021.
//

import UIKit

class TableViewDarkStyle: UITableView {
    // MARK: Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configure () {
        self.backgroundColor = .black
        self.separatorColor = .gray
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 100
        self.separatorInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 5.0)
        self.isHidden = false
        self.tableFooterView = UIView ()
    }
}
