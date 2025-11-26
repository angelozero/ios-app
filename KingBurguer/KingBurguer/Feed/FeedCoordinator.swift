//
//  FeedCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 21/10/25.
//

import Foundation

class FeedCoordinator {
    
    private let feedViewModel: FeedViewModel
    
    init() {
        self.feedViewModel = FeedViewModel(interactor: FeedInteractor())
    }
    
    func fetchFeed(){
        feedViewModel.fetchFeed()
    }
    
}
