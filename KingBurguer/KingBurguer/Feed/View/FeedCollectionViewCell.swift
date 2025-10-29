//
//  FeedCollectionViewCell.swift
//  KingBurguer
//
//  Created by angelo on 28/10/25.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    
    static let identifier = "FeedCollectionViewCell"

    let imageView: UIImageView = {
       let image = UIImageView()
        
        image.image = UIImage(named: "example")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
