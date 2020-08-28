//
//  CartManager.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 27.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let productKey = "LIKED_PHOTOS"
    
    private var likedPhotos: [String: [String]] {
        let array = defaults.object(forKey: productKey) as? [String: [String]]
        return array ?? [:]
    }
    
    func productLiked(by id: String, _ breed: String) -> Bool {
        guard let breedPhotos = likedPhotos[breed] else { return false }
        return breedPhotos.contains(id)
    }
    
    func getAllLikedPhotos() -> [String: [String]] {
        return likedPhotos
    }
    
    func toggleFavorite(_ id: String, _ breed: String) -> Bool {
        let liked: Bool
        var breeds = likedPhotos
        var photoIds = breeds[breed] ?? []
        if photoIds.contains(id), let index = photoIds.firstIndex(of: id) {
            photoIds.remove(at: index)
            liked = false
        } else {
            photoIds.append(id)
            liked = true
        }
        
        if breeds[breed] != nil {
            if photoIds.count == 0 {
                breeds[breed] = nil
            } else {
                breeds[breed]! = photoIds
            }
        } else {
            breeds[breed] = photoIds
        }
        
        defaults.set(breeds, forKey: productKey)
        return liked
    }
}
