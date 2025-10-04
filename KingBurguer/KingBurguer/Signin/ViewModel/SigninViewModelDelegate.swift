//
//  SigninViewModelDelegate.swift
//  KingBurguer
//
//  Created by angelo on 04/10/25.
//

import Foundation


protocol SignInViewModelDelegate: AnyObject {
    func viewModelDidChanged(state: SignInState)

}
