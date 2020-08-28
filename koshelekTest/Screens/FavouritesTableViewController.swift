//
//  FavouritesTableViewController.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 24.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    
    private let cartManager = CartManager.shared
    
    private var likedBreeds: [LikedBreedModel] {
        return cartManager.getAllLikedPhotos().map { LikedBreedModel(breed: $0.key, likedPhotos: $0.value) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likedBreeds.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath)
        
        let item = likedBreeds[indexPath.row]
        cell.textLabel?.text = "\(item.breed) (\(item.likedPhotos.count) photos)".capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = likedBreeds[indexPath.row]
        performSegue(withIdentifier: "getLikedImages", sender: breed)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let breed = sender as? LikedBreedModel else { return }
        
        if segue.identifier == "getLikedImages" {
            let vc = segue.destination as! ImageCollectionViewController
            vc.kind = breed.breed
            vc.imageArray = breed.likedPhotos
        }
    }
    
}
