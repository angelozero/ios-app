//
//  SignUpViewModel.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation

class SignUpViewModel {
   
    var signUpcoordinator: SignUpCoordinator?
    
   
    func goToSignUp(){
        signUpcoordinator?.start()
    }
}
