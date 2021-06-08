//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Alexandr Evtodiy on 01.05.2021.
//

import UIKit

class RegistrationViewController: UIViewController, ShowAlert, CheckingUsernameAndPassword {
    // MARK: Properties
    private var user: User?
    private var realmUserService: RealmUserServiceProtocol
    private var separatorFactoryAbstract: SeparatorFactoryAbstract
    
    var onMap: ((User) -> Void)?
    
    private var registrationView: RegistrationView {
        get {
            return view as! RegistrationView
        }
    }
    
    // MARK: Init
    init(realmUserService: RealmUserServiceProtocol,
         separatorFactoryAbstract: SeparatorFactoryAbstract) {
        self.realmUserService = realmUserService
        self.separatorFactoryAbstract = separatorFactoryAbstract
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        view = RegistrationView(separatorFactoryAbstract: separatorFactoryAbstract)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = "Registration"
        let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTouchUpInside))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    // MARK: Private functions
    private func  showSuccessRegistration (handlerOfAction: ((UIAlertAction) -> Void)?) {
        showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Registration was success", withTitleOfAction: "OK", handlerOfAction: handlerOfAction)
    }
    
    private func  showFailedRegistration () {
        showAlert(forViewController: self, withTitleOfAlert: "Notification", andMessage: "Registration was failed.", withTitleOfAction: "OK", handlerOfAction: nil)
    }
    
    func  createUserToRealm (username: String?, password: String?) -> Bool? {
        guard let login = username,
              let password = password else {return false}
        switch realmUserService.registrationUser(login: login, password: password) {
        case .success (let user):
            self.user = user
            return true
        case .failure (let error):
            if let error = error as? DataUserError {
                showError(forViewController: self, withMessage: error.rawValue)
            } else {
                showError(forViewController: self, withError: error)
            }
            return false
        case .none:
            return nil
        }
    }
    
    //MARK: Actions
    @objc private func doneButtonTouchUpInside () {
        let username = registrationView.dataUserView.usernameTextField.text
        let password = registrationView.dataUserView.passwordTextField.text
        switch checkUsernameAndPassword(username: username, password: password) {
        case .success( _):
            guard let result = createUserToRealm(username: username, password: password),
                  result == true,
                  let user = user
            else {
                showFailedRegistration()
                return}
            showSuccessRegistration { [weak self] _ in
                guard let self = self else {return}
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.set(user.username, forKey: "username")
                self.onMap?(user)
            }
        case .failure(let error):
            showError(forViewController: self, withMessage: error.rawValue)
        case .none:
            return
        }
    }
}

