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
    
    init(window: UIWindow?){
        self.window = window
    }
    
    func start(){
        let homeViewController = HomeViewController()
        homeViewController.navigationItem.title = "Home"

        window?.rootViewController = homeViewController
    }
}
