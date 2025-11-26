//
//  HomeCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation
import UIKit

class HomeCoordinator {
    private let window: UIWindow?
    
    private let feedCoordinator: FeedCoordinator!
    
    init(window: UIWindow?){
        self.window = window
        self.feedCoordinator = FeedCoordinator()
    }
    
    func start(){
        let homeViewController = HomeViewController()
        homeViewController.navigationItem.title = "Home"
        
        feedCoordinator.fetchFeed()

        window?.rootViewController = homeViewController
    }
}
