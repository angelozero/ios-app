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
    
    init(window: UIWindow?, navigationController: UINavigationController){
        self.window = window
        self.navigationController = navigationController
    }
    
    func start(){
        let signUpViewController = SignUpViewController();
        signUpViewController.navigationItem.title = "Register"
        
        self.navigationController.pushViewController(signUpViewController, animated: true)

    }
}
