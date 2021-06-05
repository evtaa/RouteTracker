//
//  TableScreenView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 09.05.2021.
//

import Foundation
import UIKit
class TableScreenDarkStyle: UIView {
    //MARK: - Subviews
    let tableView = TableViewDarkStyle ()
    let refreshControl = RefreshControlDarkStyle ()
    let resultView = ResultViewDarkStyle ()
    let resultLabel = LabelDarkStyle ()
    let indicator = ActivityIndicatorDarkStyle()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    private func configureUI () {
        self.backgroundColor = .black
        self.configureTableView()
        self.configureEmptyResultView()
        //self.configureActivityIndicator()
        self.setupConstraints()
    }
    
    private func configureTableView () {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        self.addSubview(self.tableView)
    }
    
    private func configureEmptyResultView() {
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        self.resultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.resultLabel.textColor = .gray
        self.resultLabel.textAlignment = .center
        self.addSubview(self.resultView)
        self.resultView.addSubview(self.resultLabel)
    }
    
    private func configureActivityIndicator() {
        self.addSubview(self.indicator)
    }
   
    private func setupConstraints () {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0.0),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.resultView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.resultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.resultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.resultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.resultLabel.topAnchor.constraint(equalTo: self.resultView.topAnchor, constant: 12.0),
            self.resultLabel.leadingAnchor.constraint(equalTo: self.resultView.leadingAnchor),
            self.resultLabel.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor),
        ])
    }
}
