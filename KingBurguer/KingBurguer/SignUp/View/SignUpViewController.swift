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
    
    let scroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "enter your name..."
        textField.returnKeyType = .next
        textField.delegate = self
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorMessage = "Invalid Name"
        textField.failureFunc = {
            return textField.text != "" && textField.text.count <= 3
        }
        return textField
    }()
    
    lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "enter your email..."
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.delegate = self
        textField.tag = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorMessage = "Invalid Email (format: aaa@bbb.com)"
        textField.failureFunc = {
            return !textField.text.isEmpty && !textField.text.isInvalidEmail
        }
        return textField
    }()
    
    lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "enter your password..."
        textField.returnKeyType = .next
        textField.delegate = self
        textField.tag = 3
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorMessage = "Invalid Password"
        textField.failureFunc = {
            return textField.text != "" && textField.text.count <= 5
        }
        return textField
    }()
    
    lazy var cpfTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "enter your CPF..."
        textField.returnKeyType = .next
        textField.delegate = self
        textField.tag = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorMessage = "Invalid CPF (format: 000.000.000-00)"
        textField.failureFunc = {
            return !textField.text.isEmpty && !textField.text.isIvalidCPFFormat
        }
        return textField
    }()
    
    lazy var birthdayTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "enter your birthday..."
        textField.returnKeyType = .done
        textField.delegate = self
        textField.tag = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorMessage = "Invalid Birthday (format: DD/MM/YYYY)"
        textField.failureFunc = {
            return !textField.text.isEmpty && !textField.text.isInvalidBirthDate
        }
        return textField
    }()
    
    lazy var saveButton: LoadingButton = {
        let button = LoadingButton()
        button.title = "save"
        button.titleColor = .white
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapSaveButton))
        button.roundedButton(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        
        container.backgroundColor = UIColor.systemBackground
        container.addSubview(nameTextField)
        container.addSubview(emailTextField)
        container.addSubview(passwordTextField)
        container.addSubview(cpfTextField)
        container.addSubview(birthdayTextField)
        container.addSubview(saveButton)
        
        scroll.addSubview(container)
        view.addSubview(scroll)
        view.backgroundColor = .systemBackground
        
        let scrollConstraints = [
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let heightConstraint = container.heightAnchor.constraint(equalTo: view.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        let containerConstraints = [
            container.widthAnchor.constraint(equalTo: view.widthAnchor),
            container.topAnchor.constraint(equalTo: scroll.topAnchor),
            container.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
        ]
        
        let nameConstraints = [
            nameTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10.0),
            nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10.0),
            nameTextField.topAnchor.constraint(equalTo: container.topAnchor, constant: 70.0),
            //            nameTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let emailConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10.0),
            //            emailTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let passwordConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            //            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let cpfConstraints = [
            cpfTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            cpfTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            cpfTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            //            cpfTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let birthdayConstraints = [
            birthdayTextField.leadingAnchor.constraint(equalTo: cpfTextField.leadingAnchor),
            birthdayTextField.trailingAnchor.constraint(equalTo: cpfTextField.trailingAnchor),
            birthdayTextField.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor, constant: 10.0),
            //            birthdayTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let saveButtonConstraints = [
            saveButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 50.0),
            saveButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50.0),
            saveButton.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 10.0),
            saveButton.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(cpfConstraints)
        NSLayoutConstraint.activate(birthdayConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func didTapSaveButton(_ sender: UIButton){
        saveButton.startLoading(true)
        signUpViewModel.send()
    }
    
    @objc func onKeyboardNotification(_ notification: Notification){
        let isVisibile = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = isVisibile ? UIResponder.keyboardFrameEndUserInfoKey : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(isVisibile, height: keyboardSize.height)
        }
    }
    
    func onKeyboardChanged(_ isVisible: Bool, height: CGFloat){
        if(!isVisible){
            scroll.contentInset = .zero
            scroll.scrollIndicatorInsets = .zero
        } else {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: height, right: 0.0)
            scroll.contentInset = contentInsets
            scroll.scrollIndicatorInsets = contentInsets
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField.returnKeyType == .done){
            view.endEditing(true)
            print("Cadastro Realizado")
            
        } else {
            let nextTag =  textField.tag + 1
            let component = container.findViewByTag(tag: nextTag) as? TextField
            
            if(component != nil){
                component?.gainFocus()
            } else {
                view.endEditing(true)
            }
        }
        
        return false
    }
}

extension UIView {
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
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
