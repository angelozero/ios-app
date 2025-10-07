//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation

class SignUpViewModel {
   
    weak var signUpViewModelDelegate: SignUpViewModelDelegate?
    var signUpcoordinator: SignUpCoordinator?
    
    var state: SignUpState = .none {
        didSet {
            signUpViewModelDelegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send(){
        state =  .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.state = .error(errorMessage: "Fail to save user")
        }
    }
   
    func registerUser(){
        print("Register ok")
    }
    
}
