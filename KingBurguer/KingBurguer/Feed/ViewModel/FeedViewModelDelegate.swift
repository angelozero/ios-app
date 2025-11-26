//
//  FeedViewModelDelegate.swift
//  KingBurguer
//
//  Created by angelo on 25/11/25.
//

import Foundation

protocol FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState)
}
