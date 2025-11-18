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
    //var parentCoordinator: SignInCoordinator?
    var signUpcoordinator: SignUpCoordinator?
    var homeCoordinator: HomeCoordinator?
    var infiniteScrollCoordinator: InfiniteScrollCoordinator?
    
    init(window: UIWindow?){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start(){
        let signInViewModel = SignInViewModel(interactor: SignInInteractor())
        signInViewModel.coordinatorSignIn = self
        let signInViewController = SignInViewController(signInViewModel: signInViewModel)
        
        signInViewController.navigationItem.title = "Login"
        
        self.navigationController.pushViewController(signInViewController, animated: true)
        
        window?.rootViewController = navigationController
    }
    
    
    func goToSignUp(){
        signUpcoordinator = SignUpCoordinator(window: window, navigationController: self.navigationController, parentCoordinator: self)
        signUpcoordinator?.start()
    }
    
    func goToHome(){
        homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator?.start()
    }
    
    func goToInfiniteScrollPage(){
        infiniteScrollCoordinator = InfiniteScrollCoordinator(window: window, navigationController: self.navigationController)
        infiniteScrollCoordinator?.start()
    }
}
