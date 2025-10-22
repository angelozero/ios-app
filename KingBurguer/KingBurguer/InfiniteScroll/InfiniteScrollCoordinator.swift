//
//  InfiniteScrollCoordinator.swift
//  KingBurguer
//
//  Created by angelo on 18/10/25.
//

import Foundation
import UIKit

class InfiniteScrollCoordinator {
    
    private let window: UIWindow?
    private let navigationController: UINavigationController
    
    init(window: UIWindow?, navigationController: UINavigationController){
        self.window = window
        self.navigationController = navigationController
    }
    
    func start(){
        let infiniteScrollModel = InfiniteScrollModel()
        infiniteScrollModel.infiniteScrollCoordinator = self
        let infiniteScrollController = InfiniteScrollViewController(infiniteScrollModel: infiniteScrollModel)
        
        infiniteScrollController.navigationItem.title = "Infinite Scroll"
        
        self.navigationController.pushViewController(infiniteScrollController, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
