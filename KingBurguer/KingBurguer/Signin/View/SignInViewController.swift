//
//  SigninViewController.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
    // Tornamos a viewModel obrigatória (não-opcional)
    let signInViewModel: SignInViewModel
    
    // Inicializador que requer o ViewModel
    init(signInViewModel: SignInViewModel) {
        // 1. Inicialização Própria: Garante que 'signInViewModel' está pronto.
        self.signInViewModel = signInViewModel
        
        // 2. Inicialização da Superclasse: Torna 'self' seguro e completo.
        super.init(nibName: nil, bundle: nil)
        
        // 3. Configuração Pós-Inicialização: Usa 'self' e 'signInViewModel' que agora são válidos.
        self.signInViewModel.delegate = self
    }
    
    // Este é um inicializador obrigatório em UIViewController que usa storyboards ou NIBs,
    // mas precisamos dele mesmo usando programação pura para conformidade.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // leadingAnchor ----- esquerda
    // trailingAnchor ---- direita
    // topAnchor --------- cima
    // bottomAchor -------- baixo
    
    // centerYAnchor ------ eixo Y | vertical
    // centerXAnchor ------ eixo X | horizontal
    
    // heightAnchor ------- altura
    // widthAnchor -------- largura
    
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // declarar o componente sendButton como lazy var faz com que ele seja construido apos a inicializacao da classe
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("send", for: UIControl.State.normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        // evento de clique do botao
        // self -------- referencia que o alvo a ser executado esta nesta classe
        // #selector --- método a ser executado, deve ter na frente a annotation @objc
        // for --------- evento do qual o botão ira executar a funcao
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(sendButton)
        
        let emailConstraints = [
            // posicionamento baseado no tamanho da tela inteira
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstraints = [
            // posicionamento baseado na posicao do campo email
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0),
        ]
        
        let sendButtonConstraints = [
            // posicionamento baseado no tamanho da tela inteira
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0),
            sendButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10.0),
            sendButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(sendButtonConstraints)
        
        
    }
    
    @objc func didTapSendButton(_ sender: UIButton){
        signInViewModel.send()
    }
    
    
}

// Observador do ViewModel
extension SignInViewController: SigninViewModelDelegate {
    func viewModelDidChanged(state: SignInState){
        
        switch(state){
            
        case .none:
            printState(state: .none)
            break
            
        case .loading:
            printState(state: .loading)
            break
            
        case .success:
            printState(state: .success)
            break
            
        case .error(errorMessage: let errorMessage):
            let alert  = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
            break
            
        }
    }
    
    func printState(state: SignInState){
        print("Status \(state)")
    }
}
