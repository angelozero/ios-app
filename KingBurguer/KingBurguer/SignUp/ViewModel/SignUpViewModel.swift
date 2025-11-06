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
        
//        simulando delay de 2 segs
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            self.state = .success
//        }
        
        WebServiceAPI.shared.createUser()
    }
   
    func registerUser(){
        print("User saved")
    }
    
    func goToHome(){
        signUpcoordinator?.goToHome()
    }
    
}
