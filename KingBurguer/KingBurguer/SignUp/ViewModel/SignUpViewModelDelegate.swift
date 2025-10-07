//
//  SignUpViewModelDelegate.swift
//  KingBurguer
//
//  Created by angelo on 06/10/25.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    func viewModelDidChanged(state: SignUpState)

}
