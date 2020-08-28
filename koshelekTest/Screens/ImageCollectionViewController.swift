//
//  ImageCollectionViewController.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 25.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import UIKit
import Kingfisher



class ImageCollectionViewController: UICollectionViewController {
    
    let sectionInserts = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    
    public var kind: String!
    public var mainBreed: String?
    public var imageUrl: String!
    
    
    var imageArray = [String]()
    
    private let cartManager = CartManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isPagingEnabled = true
        
        if imageArray.count == 0 {
            fetchImage()
        } else {
            
            self.navigationItem.title = self.kind
            self.collectionView.reloadData()
            
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let imageView = UIImageView()
        
        imageView.kf.setImage(with: URL(string: imageUrl))
        
        let shareController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
    }
    
    private func fetchImage() {
        let mainBreedString = mainBreed != nil ? "\(mainBreed!)/" : ""
        
        NetworkManager.downloadImage(url: "https://dog.ceo/api/breed/\(mainBreedString)\(kind ?? "")/images") { (imageArray) in
            self.imageArray = imageArray
            DispatchQueue.main.async {
                self.navigationItem.title = self.kind
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let main = mainBreed != nil ? mainBreed! + " -> " : ""
        let breedKind = "\(main)\(kind!)"
        imageUrl = imageArray[indexPath.item]
        let isLiked = cartManager.productLiked(by: imageUrl, breedKind)
        cell.configure(with: imageUrl, isLiked, breedKind)
        
        return cell
    }
    
}


extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
