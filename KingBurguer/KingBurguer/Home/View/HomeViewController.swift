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
        
        feedViewController.title = "Feed"
        coupomViewController.title = "Coupom"
        profileViewController.title = "Profile"
        
        // adicionando icones ---> SF Symbols
        feedViewController.tabBarItem.image = UIImage(systemName: "house")
        coupomViewController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        
        setViewControllers([feedViewController, coupomViewController, profileViewController], animated: true)
    }
}
