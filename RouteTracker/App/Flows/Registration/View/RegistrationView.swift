//
//  RegistrationView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 30.04.2021.
//

import UIKit

class RegistrationView: UIView {
    //MARK: Subviews
    let scrollView = UIScrollView()
    let dataUserView: DataUserViewDarkStyle
    
    // MARK: Init
    required init(separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.dataUserView = DataUserViewDarkStyle(separatorFactoryAbstract: separatorFactoryAbstract)
        super.init(frame: .zero)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configureUI () {
        accessibilityIdentifier = "registrationView"
        backgroundColor = .black
        configureScrollView()
        configureDataUserView()
        setupConstraints()
    }
    
    // MARK: Private functions
    private func configureScrollView () {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }
    private func configureDataUserView () {
        dataUserView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(dataUserView)
    }
    
    private func setupConstraints () {
        let scrollArea = self.scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            
            dataUserView.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: 30.0),
            dataUserView.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: 10),
            dataUserView.trailingAnchor.constraint(equalTo: scrollArea.trailingAnchor, constant: -10),
            dataUserView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}
