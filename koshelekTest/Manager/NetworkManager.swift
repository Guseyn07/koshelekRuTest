//
//  NetworkManager.swift
//  koshelekTest
//
//  Created by Guseyn Gasharov on 24.08.2020.
//  Copyright © 2020 Guseyn Gasharov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var imageArray = [UIImage]()
    
    static func getBreeds(success: @escaping ([BreedModel]) -> Void) {
        
        AF
            .request("https://dog.ceo/api/breeds/list/all", method: .get)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let mainDict = value as? [String: Any] {
                        if let messageDict = mainDict["message"] as? [String: [String]] {
                            var result = [BreedModel]()
                            
                            messageDict.forEach {
                                let breed = BreedModel(breed: $0.key, subbreed: $0.value)
                                result.append(breed)
                            }
                            result.sort { $0.breed < $1.breed }
                            success(result)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: [String]) -> Void) {
        
        AF
            .request(url)
            .responseJSON { (responseJSON) in
                switch responseJSON.result {
                    
                case .success(let value):
                    if let json = value as? [String: Any] {
                        if let imageUrls = json["message"] as? [String] {
                            DispatchQueue.main.async {
                                completion(imageUrls)
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
