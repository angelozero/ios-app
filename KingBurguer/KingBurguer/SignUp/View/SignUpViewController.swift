//
//  SignUpViewController.swift
//  KingBurguer
//
//  Created by angelo on 02/10/25.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    let signUpViewModel: SignUpViewModel
    
    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
        self.signUpViewModel.signUpViewModelDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "enter your name..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "enter your email..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "enter your password..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let cpfTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "enter your CPF..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.placeholder = "enter your birthday..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(cpfTextField)
        view.addSubview(birthdayTextField)
        view.addSubview(saveButton)
        
        let nameConstraints = [
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            nameTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let emailConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let passwordConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let cpfConstraints = [
            cpfTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            cpfTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            cpfTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            cpfTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let birthdayConstraints = [
            birthdayTextField.leadingAnchor.constraint(equalTo: cpfTextField.leadingAnchor),
            birthdayTextField.trailingAnchor.constraint(equalTo: cpfTextField.trailingAnchor),
            birthdayTextField.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor, constant: 10.0),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let saveButtonConstraints = [
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            saveButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 10.0),
            saveButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(cpfConstraints)
        NSLayoutConstraint.activate(birthdayConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
    
    @objc func didTapSaveButton(_ sender: UIButton){
       // signUpViewModel.registerUser()
        signUpViewModel.send()
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    
    func viewModelDidChanged(state: SignUpState){
        switch(state){
            
        case .none:
            printState(state: SignUpState.none)
            break
            
        case .loading:
            printState(state: SignUpState.loading)
            break
            
        case .success:
            signUpViewModel.goToHome()
            break
            
        case .error(errorMessage: let errorMessage):
            let alert  = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
            
        }
    }
}


func printState(state: SignUpState){
    print("Status \(state)")
}
