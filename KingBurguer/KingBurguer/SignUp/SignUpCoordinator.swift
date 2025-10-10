//
//  SignUpCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation
import UIKit

class SignUpCoordinator {
    private let window: UIWindow?
    private let navigationController: UINavigationController
    weak var parentCoordinator: SignInCoordinator?
    
    init(window: UIWindow?, navigationController: UINavigationController, parentCoordinator: SignInCoordinator?){
        self.window = window
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start(){
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.signUpcoordinator = self
        
        let signUpViewController = SignUpViewController(signUpViewModel: signUpViewModel);
        signUpViewController.navigationItem.title = "Register"
        
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func goToHome(){
        parentCoordinator?.goToHome()
    }
}
