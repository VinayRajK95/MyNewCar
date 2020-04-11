//
//  Networking.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import Foundation

class NetworkController {
    
    fileprivate let api = "http://api.tvmaze.com/search/shows?q=girls"
    
    let session = URLSession.shared

    internal  func fetchJSON( completion: @escaping ([Movie]?)  -> () ) {
        guard let url = URL(string: api) else { return }
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, response != nil, error == nil else { completion(nil); return }
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode([Movie].self, from: data)
                completion(movies)
            }
            catch {
                completion(nil)
                print("Unable to convert to JSON")
            }
        }.resume()
    }
    
    internal func fetchImage(url: String?, completion: @escaping (Data)  -> () ) {
        guard let url = url, let imageURL = URL(string: url) else { return }
        session.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data, response != nil, error == nil else { return }
            completion(data)
        }.resume()
    }
}
