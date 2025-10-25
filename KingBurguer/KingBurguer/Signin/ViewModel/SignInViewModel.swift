//
//  SigninViewModel.swift
//  KingBurguer
//
//  Created by angelo on 30/09/25.
//

import Foundation


class SignInViewModel {
    
    weak var signInViewModelDelegate: SignInViewModelDelegate?
    var coordinatorSignIn: SignInCoordinator?
    
    var state: SignInState = .none {
        didSet {
            signInViewModelDelegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send(){
        state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            //self.state = .error(errorMessage: "Not Authorized")
            self.state = .success
        }
    }
    
    func goToSignUp(){
        coordinatorSignIn?.goToSignUp()
    }
    
    func goToHome(){
        coordinatorSignIn?.goToHome()
    }
    
    func goToInfiniteScrollPage(){
        coordinatorSignIn?.goToInfiniteScrollPage()
    }
}
