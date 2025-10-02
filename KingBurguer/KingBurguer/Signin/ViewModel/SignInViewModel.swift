//
//  SigninViewModel.swift
//  KingBurguer
//
//  Created by angelo on 30/09/25.
//

import Foundation


protocol SigninViewModelDelegate: AnyObject {
    func viewModelDidChanged(state: SignInState)
}


class SignInViewModel {
    
    weak var delegate: SigninViewModelDelegate?
    
    var state: SignInState = .none {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send(){
        state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.state = .error(errorMessage: "Lele is blocked")
        }
    }
}
