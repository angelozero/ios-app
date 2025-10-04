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
    
    init(window: UIWindow?){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start(){
        let signInViewModel = SignInViewModel()
        let signInViewController = SignInViewController(signInViewModel: signInViewModel)
        
        self.navigationController.viewControllers = [signInViewController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
