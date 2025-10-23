//
//  HomeViewController.swift
//  KingBurguer
//
//  Created by angelo on 07/10/25.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.tintColor = .systemRed

        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        let coupomViewController = UINavigationController(rootViewController: CoupomViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let gridViewController = UINavigationController(rootViewController: GridViewController())
        
        feedViewController.title = "Feed"
        coupomViewController.title = "Coupom"
        profileViewController.title = "Profile"
        gridViewController.title = "Grid"
        
        // adicionando icones ---> SF Symbols
        feedViewController.tabBarItem.image = UIImage(systemName: "house")
        coupomViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        gridViewController.tabBarItem.image = UIImage(systemName: "square.grid.3x3")
        
        setViewControllers([feedViewController, coupomViewController, profileViewController, gridViewController], animated: true)
    }
}
