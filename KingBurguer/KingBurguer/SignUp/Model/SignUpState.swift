//
//  SignUpState.swift
//  KingBurguer
//
//  Created by angelo on 06/10/25.
//

import Foundation

enum SignUpState {
    case none
    case loading
    case success
    case error(errorMessage: String)
    
}
