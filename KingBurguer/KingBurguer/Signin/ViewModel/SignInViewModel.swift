//
//  SigninViewModel.swift
//  KingBurguer
//
//  Created by angelo on 30/09/25.
//

import Foundation


protocol SigninViewModelDelegate: AnyObject {
    func viewModelDidChanged(viewModel: SignInViewModel)
}


class SignInViewModel {
    
    weak var delegate: SigninViewModelDelegate?
    
    func send(){
        delegate?.viewModelDidChanged(viewModel: self)
    }
}
