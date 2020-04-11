//
//  ViewModel.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit
import Foundation

class ViewModel {
    
    internal let networkController = NetworkController()
    
    internal var modelData : [Movie]? = nil
    
    weak var delegate: Operations? = nil
    
    internal func fetchData() {
        networkController.fetchJSON(completion: updateData(movies:))
    }
    
    internal func updateData(movies: [Movie]?) {
        guard let movies = movies else { delegate?.errorOccured(); return }
        modelData = movies
        delegate?.UpdateUI()
    }
    
    internal func fetchImage(url: String?,completion: @escaping (Data)  -> ())  {
        networkController.fetchImage(url: url, completion: completion)
    }
}
