//
//  SubBreedTableViewController.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 25.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import UIKit

class SubBreedTableViewController: UITableViewController {
    
    public var subBreeds: [String] = []
    public var mainBreed: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = mainBreed
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subBreeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subBreedCell", for: indexPath)
        
        cell.textLabel?.text = subBreeds[indexPath.row].capitalized
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subBreed = subBreeds[indexPath.row]
        performSegue(withIdentifier: "getImageSubBreed", sender: subBreed)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let subBreed = sender as? String else { return }
        
        switch segue.identifier {
        case "getImageSubBreed":
            guard let destionationVC = segue.destination as? ImageCollectionViewController else { return }
            destionationVC.mainBreed = mainBreed
            destionationVC.kind = subBreed
            
        default:
            break
        }
    }
    
    
}
