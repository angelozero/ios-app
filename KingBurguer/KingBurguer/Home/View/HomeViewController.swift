//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    let homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
        self.homeViewModel.homeViewModelDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        view.backgroundColor = UIColor.systemBackground
//        view.addSubview(emailTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(logInButton)
//        view.addSubview(registerButton)
//        
//        let emailConstraints = [
//            // posicionamento baseado no tamanho da tela inteira
//            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
//            emailTextField.heightAnchor.constraint(equalToConstant: 50.0)
//        ]
//        
//        let passwordConstraints = [
//            // posicionamento baseado na posicao do campo email
//            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
//            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
//            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
//            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
//        ]
//        
//        let logInButtonConstraints = [
//            // posicionamento baseado no tamanho da tela inteira
//            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
//            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
//            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
//            logInButton.heightAnchor.constraint(equalToConstant: 50.0)
//        ]
//        
//        let registerButtonConstraints = [
//            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
//            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
//            registerButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10.0),
//            registerButton.heightAnchor.constraint(equalToConstant: 50.0)
//        ]
//        
//        NSLayoutConstraint.activate(emailConstraints)
//        NSLayoutConstraint.activate(passwordConstraints)
//        NSLayoutConstraint.activate(logInButtonConstraints)
//        NSLayoutConstraint.activate(registerButtonConstraints)
        
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func viewModelDidChanged(state: HomeState){
        switch(state){
            
        case .none:
            printState(state: HomeState.none)
            break
            
        case .loading:
            printState(state: HomeState.loading)
            break
            
        case .success:
            printState(state: HomeState.success)
            break
            
        case .error(errorMessage: let errorMessage):
            let alert  = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
            
        }
    }
}


func printState(state: HomeState){
    print("Status \(state)")
}
