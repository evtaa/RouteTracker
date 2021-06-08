//
//  DataUserViewDarkStyle.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 18.05.2021.
//

import UIKit

class DataUserViewDarkStyle: UIView {
    // MARK: - Properties
    var separatorFactoryAbstract: SeparatorFactoryAbstract
    let containerView = UIStackView()
    let usernameLabel = LabelDarkStyle()
    let usernameTextField = TextFieldDarkStyle()
    let passwordLabel = LabelDarkStyle()
    let passwordTextField = TextFieldDarkStyle()
    
    // MARK: - Init
    required init(separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.separatorFactoryAbstract = separatorFactoryAbstract
        super.init(frame: .zero)
        self.configure ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure () {
        backgroundColor = .black
        configureContainerView()
        configureUsernameLabel ()
        configureUsernameTextField ()
        configurePasswordLabel ()
        configurePasswordTextField ()
        setupConstraints()
    }
    private func configureContainerView() {
        let indentBetweenProperties = CGFloat(10)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .vertical
        containerView.distribution = .fillProportionally
        containerView.alignment = .fill
        containerView.spacing = .zero
        containerView.addArrangedSubview(usernameLabel)
        containerView.addArrangedSubview(usernameTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        containerView.addArrangedSubview(passwordLabel)
        containerView.addArrangedSubview(passwordTextField)
        containerView.addArrangedSubview(separatorFactoryAbstract.makeTranslucent(height: indentBetweenProperties))
        addSubview(containerView)
    }
    private func  configureUsernameLabel () {
        usernameLabel.text = "Username:"
    }
    private func configurePasswordLabel () {
        passwordLabel.text = "Password:"
    }
    
    private func configureUsernameTextField () {
        usernameTextField.placeholder = "username"
    }
    private func configurePasswordTextField () {
        passwordTextField.placeholder = "password"
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
                                        containerView.topAnchor.constraint(equalTo: topAnchor),
                                        containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                        containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                        containerView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
