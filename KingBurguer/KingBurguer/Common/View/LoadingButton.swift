//
//  LoadingButton.swift
//  KingBurguer
//
//  Created by angelo on 18/10/25.
//

import Foundation
import UIKit


class LoadingButton: UIView {
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let progress: UIActivityIndicatorView = {
        let prog = UIActivityIndicatorView()
        prog.translatesAutoresizingMaskIntoConstraints = false
        return prog
    }()
    
    var title: String? {
        willSet {
            button.setTitle(newValue, for: .normal )
        }
    }
    
    var titleColor: UIColor? {
        willSet {
            button.setTitleColor(newValue, for: .normal )
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet {
            button.backgroundColor = newValue
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector){
        button.addTarget(target, action: action , for: .touchUpInside)
    }
    
    func startLoading(_ loading: Bool){
        button.isEnabled = !loading
        if (loading){
            button.setTitle("", for: .normal)
            alpha = 0.5
            progress.startAnimating()
        } else {
            button.setTitle(title, for: .normal)
            alpha = 1.0
            progress.stopAnimating()
        }
    }
    
    private func setupViews(){
        backgroundColor = .red
        addSubview(button)
        addSubview(progress)
        
        let buttonConstraints = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let progressConstraints = [
            progress.leadingAnchor.constraint(equalTo: leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: trailingAnchor),
            progress.topAnchor.constraint(equalTo: topAnchor),
            progress.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(progressConstraints)
    }
}
