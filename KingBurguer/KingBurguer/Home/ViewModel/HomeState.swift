//
//  HomeState.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation

enum HomeState {
    case none
    case loading
    case success
    case error(errorMessage: String)
}
