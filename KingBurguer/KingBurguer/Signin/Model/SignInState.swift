//
//  SignInState.swift
//  KingBurguer
//
//  Created by angelo on 01/10/25.
//

import Foundation

enum SignInState {
    case none
    case loading
    case success
    case error(errorMessage: String)
}
