//
//  CoupomViewController.swift
//  KingBurguer
//
//  Created by angelo on 21/10/25.
//

import UIKit

class CoupomViewController: UIViewController {
    
    let viewTest: UIView = {
        let view = UIView(frame: CGRect(x: 50, y: 100, width: 50, height: 50))
        view.backgroundColor = .yellow
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(viewTest)
    }
}
