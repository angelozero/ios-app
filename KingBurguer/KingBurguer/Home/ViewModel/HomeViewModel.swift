//
//  HomeViewModel.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation

class HomeViewModel {
    weak var homeViewModelDelegate: HomeViewModelDelegate?
    var homecoordinator: HomeCoordinator?
    
    var state: HomeState = .none {
        didSet {
            homeViewModelDelegate?.viewModelDidChanged(state: state)
        }
    }
    
    func send(){
        state =  .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.state = .error(errorMessage: "Fail to save user")
        }
    }
   
    func registerUser(){
        print("Register ok")
    }
}
