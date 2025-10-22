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
    private let navigationController: UINavigationController
    
    init(window: UIWindow?){
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start(){
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController()
        homeViewController.navigationItem.title = "Home"
        
        self.navigationController.pushViewController(homeViewController, animated: true)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
