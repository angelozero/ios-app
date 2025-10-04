//
//  SignInCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 03/10/25.
//

import Foundation
import UIKit

class SignInCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController
    var coordinatorSignUP: SignUpCoordinator?
    
    init(window: UIWindow?){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start(){
        let signInViewModel = SignInViewModel()
        signInViewModel.coordinatorSignIn = self
        let signInViewController = SignInViewController(signInViewModel: signInViewModel)
        
        signInViewController.navigationItem.title = "Login"
        
        self.navigationController.pushViewController(signInViewController, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
    func goToSignUp(){
        let coordinate = SignUpCoordinator(window: window, navigationController: self.navigationController)
        coordinate.start()
    }
    
}
