//
//  SigninViewController.swift
//  KingBurguer
//
//  Created by angelo on 26/09/25.
//

import Foundation
import UIKit


class SignInViewController: UIViewController {
    
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
        // Evento de clique do botao
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
        print("OK")
    }
}
