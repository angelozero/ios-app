//
//  HomeViewModelDelegate.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func viewModelDidChanged(state: HomeState)
}
