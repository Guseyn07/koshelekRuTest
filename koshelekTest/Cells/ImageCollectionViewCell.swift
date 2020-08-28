//
//  ImageCollectionViewCell.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 25.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView! 
    @IBOutlet weak var likeButtonImage: UIButton!
    
    private let cartManager = CartManager.shared
    
    private var breed: String!
    private var photoUrl: String!
    private var isLiked: Bool = false {
        didSet {
            toggleLike()
        }
    }
    
    func configure(with urlString: String, _ isLiked: Bool, _ breed: String) {
        self.breed = breed
        self.photoUrl = urlString
        self.isLiked = isLiked
        imageView.kf.setImage(with: URL(string: urlString), options: [.transition(.fade(0.5))])
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        isLiked = cartManager.toggleFavorite(photoUrl, breed)
    }
    
    
    private func toggleLike() {
        let imageName = isLiked ? "like-fill" : "like"
        likeButtonImage.setImage(UIImage(named: imageName), for: .normal)
    }
    
}
