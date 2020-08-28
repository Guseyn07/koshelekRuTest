//
//  ListTableViewController.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 24.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import UIKit
import Alamofire

class ListTableViewController: UITableViewController {
    
    
    var breeds = [BreedModel]()
    
    override func viewDidLoad() {
        
        fetchData()
        
        
    }
    
    private func fetchData() {
        NetworkManager.getBreeds { (breeds) in
            self.breeds = breeds
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath) as! ListTableViewCell
        
        cell.nameLabel.text = breeds[indexPath.row].breed.capitalized
        
        let subbreedCount = breeds[indexPath.row].subbreed.count
        cell.subNameLabel.isHidden = true
        
        if subbreedCount > 0 {
            cell.subNameLabel.isHidden = false
            cell.subNameLabel.text = (String(subbreedCount) + " subbreeds")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = breeds[indexPath.row]
        
        if breed.subbreed.count > 0 {
            performSegue(withIdentifier: "openSubBreed", sender: breed)
        } else {
            performSegue(withIdentifier: "getImageBreed", sender: breed)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let breed = sender as? BreedModel else { return }
        
        switch segue.identifier {
        case "getImageBreed":
            guard let destionationVC = segue.destination as? ImageCollectionViewController else { return }
            destionationVC.kind = breed.breed
            
        case "openSubBreed":
            guard let destiщnationVC = segue.destination as? SubBreedTableViewController else { return }
            let subBreeds = breed.subbreed
            destiщnationVC.subBreeds = subBreeds
            destiщnationVC.mainBreed = breed.breed
        default:
            break
        }
    }
}



