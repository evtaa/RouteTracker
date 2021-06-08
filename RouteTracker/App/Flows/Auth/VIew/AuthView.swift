//
//  AuthView.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit

class AuthView: UIView {

    //MARK: - Subviews
    let infoDataLabel = LabelDarkStyle()
    let usernameTextField = TextFieldDarkStyle()
    let passwordTextField = TextFieldDarkStyle()
    let loginButton = ButtonDarkStyle()
    let createAccountButton = ButtonDarkStyle()
    let scrollView = ScrollViewDarkStyle ()
    
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
        self.accessibilityIdentifier = "authView"
        self.configureScrollView ()
        self.configureInfoDataLabel()
        self.configureUsernameTextField()
        self.configurePasswordTextField()
        self.configureLoginButton()
        self.configureCreateAccountButton()
        self.setupConstraints()
    }
    
    private func configureScrollView () {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    private func configureInfoDataLabel () {
        self.infoDataLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoDataLabel.accessibilityIdentifier = "resultData"
        self.infoDataLabel.isHidden = true
        self.infoDataLabel.numberOfLines = 2
        self.infoDataLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        self.scrollView.addSubview(self.infoDataLabel)
    }
    
    private func configureUsernameTextField () {
        self.usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.usernameTextField.accessibilityIdentifier = "username"
        self.usernameTextField.placeholder = "username"
        self.scrollView.addSubview(self.usernameTextField)
    }
    
    private func configurePasswordTextField () {
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.accessibilityIdentifier = "password"
        self.passwordTextField.placeholder = "password"
        self.passwordTextField.isSecureTextEntry = true
        self.scrollView.addSubview(self.passwordTextField)
    }
    
    private func configureLoginButton () {
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.accessibilityIdentifier = "login"
        self.loginButton.setTitle("Login", for: .normal)
        self.scrollView.addSubview(self.loginButton)
    }
    
    private func configureCreateAccountButton () {
        self.createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        self.createAccountButton.accessibilityIdentifier = "createAccountButton"
        self.createAccountButton.setTitle("Create a new account", for: .normal)
        self.scrollView.addSubview(self.createAccountButton)
    }
    
    private func setupConstraints () {
        let scrollArea = self.scrollView.contentLayoutGuide
        //let safeArea = self.safeAreaLayoutGuide
        let widthButton = CGFloat(80.0)
        let widthCreateAccountButton = CGFloat(175)
        let widthLabel = CGFloat(180)
        let widthTextField = CGFloat(160)
        
        NSLayoutConstraint.activate([
            
            self.scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.topAnchor),
            self.scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor),
            self.scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.bottomAnchor),
            
            self.infoDataLabel.topAnchor.constraint(equalTo: scrollArea.topAnchor, constant: CGFloat(0.3) * CGFloat(UIScreen.main.bounds.height/2) ),
            self.infoDataLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            self.infoDataLabel.heightAnchor.constraint(equalToConstant: 60),
            self.infoDataLabel.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthLabel/2),
            
            self.usernameTextField.topAnchor.constraint(equalTo: self.infoDataLabel.bottomAnchor, constant: 10.0),
            self.usernameTextField.widthAnchor.constraint(equalToConstant: widthTextField),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 20),
            self.usernameTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthTextField/2),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 10.0),
            self.passwordTextField.widthAnchor.constraint(equalToConstant: widthTextField),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 20),
            self.passwordTextField.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthTextField/2),
            
            self.loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30.0),
            self.loginButton.widthAnchor.constraint(equalToConstant: widthButton),
            self.loginButton.heightAnchor.constraint(equalToConstant: 20.0),
            self.loginButton.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthButton/2),
            
            self.createAccountButton.widthAnchor.constraint(equalToConstant: widthCreateAccountButton),
            self.createAccountButton.heightAnchor.constraint(equalToConstant: 20.0),
            self.createAccountButton.leadingAnchor.constraint(equalTo: scrollArea.leadingAnchor, constant: UIScreen.main.bounds.width/2 - widthCreateAccountButton/2),
            self.createAccountButton.bottomAnchor.constraint(equalTo: scrollArea.bottomAnchor, constant: -UIScreen.main.bounds.height/5),
        ])
    }

}
