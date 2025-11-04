//
//  SigninViewController.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    let signInViewModel: SignInViewModel
    
    init(signInViewModel: SignInViewModel) {
        self.signInViewModel = signInViewModel
        super.init(nibName: nil, bundle: nil)
        self.signInViewModel.signInViewModelDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bitmaskResult: Int = 0
    
    // declarar o componente como lazy var faz com que ele seja construido apos a inicializacao da classe
    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "email"
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.errorMessage = "Invalid Email"
        textField.bitmaskValue = SignInBitmaskValue(SignInBitmaskValueEnum.email)
        textField.delegate = self
        textField.errorMessage = "Invalid Email (format: aaa@bbb.com)"
        textField.failureFunc = {
            return !textField.text.isEmpty && !textField.text.isInvalidEmail
        }
        return textField
    }()
    
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "password"
        textField.returnKeyType = .done
        textField.errorMessage = "Invalid Password"
        textField.bitmaskValue = SignInBitmaskValue(SignInBitmaskValueEnum.password)
        textField.failureFunc = {
            return textField.text != "" && textField.text.count <= 5
        }
        textField.secureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    lazy var logInButton: LoadingButton = {
        let button = LoadingButton()
        button.title = "log in"
        button.titleColor = .white
        button.backgroundColor = .systemGray
        button.isEnable = false
        button.addTarget(self, action: #selector(didTapLogInButton))
        button.roundedButton(button)
        return button
    }()
    
    lazy var registerButton: LoadingButton = {
        let button = LoadingButton()
        button.title = "register"
        button.titleColor = .white
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapRegisterButton))
        button.roundedButton(button)
        return button
    }()
    
    lazy var infiniteScrollButton: LoadingButton = {
        let button = LoadingButton()
        button.title = "infinite scroll"
        button.titleColor = .white
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapInfiniteScrollButton))
        button.roundedButton(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Login"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(registerButton)
        view.addSubview(infiniteScrollButton)
        
        // leadingAnchor ------ esquerda
        // trailingAnchor ----- direita
        // topAnchor ---------- cima
        // bottomAchor -------- baixo
        // heightAnchor ------- altura
        // widthAnchor -------- largura
        
        let emailConstraints = [
            // posicionamento baseado no tamanho da tela inteira
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            // emailTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstraints = [
            // posicionamento baseado na posicao do campo email
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            // passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let logInButtonConstraints = [
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            logInButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let registerButtonConstraints = [
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            registerButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10.0),
            registerButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let infiniteScrollButtonConstraints = [
            infiniteScrollButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            infiniteScrollButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            infiniteScrollButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10.0),
            infiniteScrollButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        // ativando
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(logInButtonConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)
        NSLayoutConstraint.activate(infiniteScrollButtonConstraints)
        
    }
    
    func enableLoginButton(_ isEnabled: Bool){
        logInButton.isEnable = isEnabled
        if isEnabled {
            logInButton.backgroundColor = .systemRed
        } else {
            logInButton.backgroundColor = .systemGray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func didTapLogInButton(_ sender: UIButton){
        signInViewModel.send()
    }
    
    @objc func didTapRegisterButton(_ sender: UIButton){
        registerButton.clickEffect()
        signInViewModel.goToSignUp()
    }
    
    @objc func didTapInfiniteScrollButton(_ sender: UIButton){
        infiniteScrollButton.clickEffect()
        signInViewModel.goToInfiniteScrollPage()
    }
}

// Evento para alternar campos entre campos
extension SignInViewController: TextFieldDelegate {
    func textFieldDidChanged(isValid: Bool, bitmask: Int) {
        if isValid {
            self.bitmaskResult = self.bitmaskResult | bitmask
            print("is valid ---> \(bitmaskResult)")
            
        } else  {
            self.bitmaskResult = self.bitmaskResult & ~bitmask
            print("is invalid ---> \(bitmaskResult)")
        }

        let isEnabled = (SignInBitmaskValueEnum.email.rawValue & self.bitmaskResult != 0)
                        && (SignInBitmaskValueEnum.password.rawValue & self.bitmaskResult != 0)
        
        enableLoginButton(isEnabled)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == .done){
            view.endEditing(true)
            print("Botao Password - Entrando")
        } else {
            passwordTextField.gainFocus()
        }
        return false
    }
}

// Observador do ViewModel - Implementacao do protocolo SigninViewModelDelegate
extension SignInViewController: SignInViewModelDelegate {
    
    func viewModelDidChanged(state: SignInState){
        switch(state){
            
        case .none:
            printState(state: SignInState.none)
            break
            
        case .loading:
            logInButton.startLoading(true)
            printState(state: SignInState.loading)
            break
            
        case .success:
            signInViewModel.goToHome()
            
        case .error(errorMessage: let errorMessage):
            let alert  = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
        }
    }
    
    func validationCharactersEmailField() -> Bool {
        return emailTextField.text != "" && emailTextField.text.count <= 3
    }
}

func printState(state: SignInState){
    print("Status \(state)")
}



