//
//  AuthViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 29.04.2021.
//

import UIKit

class AuthViewController: UIViewController, ShowAlert, CheckingUsernameAndPassword {
    // MARK: Properties
    private var hideKeyboardGesture: UITapGestureRecognizer?
    private var realmUserService: RealmUserServiceProtocol?
    private var user: User?
    
    var onLogin: ((User) -> Void)?
    var onRegistration: (() -> Void)?
    
    // MARK: Private properties
    private var authView: AuthView {
        return self.view as! AuthView
    }
    
    //MARK: Init
    init(realmUserService: RealmUserServiceProtocol) {
        self.realmUserService = realmUserService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        view = AuthView ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Configure
    private func configure () {
        configureActions()
        configureKeyboard ()
    }
    
    private func configureActions () {
        authView.loginButton.addTarget(self, action: #selector(loginButtonTouchUpInside), for: .touchUpInside)
        authView.createAccountButton.addTarget(self, action: #selector(createAccountButtonTouchUpInside), for: .touchUpInside)
    }
    
    private func configureKeyboard () {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc func keyboardWasShown(notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              let kbSize = (userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size else {
            return}
        debugPrint(kbSize.height)
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.authView.scrollView.contentInset = contentInsets
        self.authView.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              let kbSize = (userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size else {
            return}
        let contentInsets = UIEdgeInsets.zero
        authView.scrollView.contentInset = contentInsets
        authView.scrollView.scrollIndicatorInsets = contentInsets
        authView.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - kbSize.height ), animated: true)
    }
    
    // MARK: Private functions
    private func showInfoData(message: String) {
        authView.infoDataLabel.text = message
        authView.infoDataLabel.isHidden = false
    }
    
    private func checkUserInRealm (username: String?, password: String?) -> Bool? {
        guard let realmUserService = realmUserService,
              let username = username,
              let password = password else {return nil}
        let user = realmUserService.getUserFromLoginAndPassword(login: username, password: password)
        switch user {
        case .success (let user):
            self.user = user
            return true
        case .failure (let error):
            showInfoData(message: error.rawValue)
            return false
        case .none:
            return nil
        }
    }
    
    // MARK: Actions
    @objc func loginButtonTouchUpInside () {
        let username = authView.usernameTextField.text
        let password = authView.passwordTextField.text
        switch checkUsernameAndPassword(username: username, password: password) {
        case .success( _):
            guard let result = checkUserInRealm(username: username, password: password),
                  result == true,
                  let user = user
            else {return}
            UserDefaults.standard.set(true, forKey: "isLogin")
            UserDefaults.standard.set(user.username, forKey: "username")
            onLogin?(user)
        case .failure(let error):
            showInfoData(message: error.rawValue)
        case .none:
            return
        }
    }
    
    @objc func createAccountButtonTouchUpInside () {
        onRegistration?()
    }
}
