//
//  FeedViewModel.swift
//  KingBurguer
//
//  Created by angelo on 18/11/25.
//

import Foundation


class FeedViewModel {
    
    private let feedInteractor: FeedInteractor
    var delegate: FeedViewModelDelegate?
    var state: FeedState = .loading {
        didSet {
            delegate?.viewModelDidChanged(state: state)
        }
    }
    
    init(interactor: FeedInteractor) {
        self.feedInteractor = interactor
    }
    
    func fetchFeed(){
        
        feedInteractor.fetchFeed(){ data, error in
            
            DispatchQueue.main.async {
                if let dataResponse = data {
                    print("FIM FEED")
                    print("TOTAL CATEGORIAS: \(dataResponse.categories.count)")
                    
                } else {
                    print("ERRO FIM FEED")
                }
            }
        }
    }
}
