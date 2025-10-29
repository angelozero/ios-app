//
//  Highlight.swift
//  KingBurguer
//
//  Created by angelo on 24/10/25.
//

import UIKit

class HighlightView: UIView {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "highlight")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Redeem Coupon", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.5
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addGradient()
        
        addSubview(infoButton)
        applyConstraints()
    }
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemRed.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints(){
        let infoButtonConstraints = [
            infoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8),
            infoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
        ]
        
        NSLayoutConstraint.activate(infoButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
