//
//  SigninViewController.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    
    let emailTextField: UITextField = {
        let editText = UITextField()
        editText.backgroundColor = .white
        editText.placeholder = "email"
        editText.translatesAutoresizingMaskIntoConstraints = false
        return editText
    }()
    
    let passwordTextField: UITextField = {
        let editText = UITextField()
        editText.backgroundColor = .white
        editText.placeholder = "password"
        editText.translatesAutoresizingMaskIntoConstraints = false
        return editText
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        
//        emailTextField.frame = CGRect(
//            x: 0,
//            y: view.coordinateSpace.bounds.size.height / 2,
//            width: view.coordinateSpace.bounds.size.width,
//            height: 50)
        
//        passwordTextField.frame = CGRect(
//            x: 0,
//            y: (view.coordinateSpace.bounds.size.height / 2) + 100,
//            width: view.coordinateSpace.bounds.size.width,
//            height: 50)
        
        let emailConstraints = [
            // cooredenadas da esquerda
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            // cooredenadas da direita
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // cooredenadas do centro Y
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // cooredenadas do tamanho | altura
            emailTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstraints = [
            // cooredenadas da esquerda
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            // cooredenadas da direita
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // cooredenadas do centro Y
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            // cooredenadas do tamanho | altura
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        
    }
}
