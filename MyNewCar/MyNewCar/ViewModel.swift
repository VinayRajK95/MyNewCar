//
//  ViewModel.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit
import Foundation

class ViewModel: NSObject, DSDelegate {

    internal let networkController = NetworkController()
    
    internal var modelData : [Movie]? = nil
    
    weak var delegate: Operations? = nil
    
    internal var view = MainView()
    
    internal var dataSource: CollectionviewDSandDelegate!
    
    override init() {
        dataSource = CollectionviewDSandDelegate()
        dataSource.collectionView = view.collectionView
        
        view.collectionView.delegate = dataSource
        view.collectionView.dataSource = dataSource
    }
    
    internal func fetchData() {
        networkController.fetchJSON(completion: updateData(movies:))
    }
    
    internal func updateData(movies: [Movie]?) {
        guard let movies = movies else { delegate?.errorOccured(); return }
        modelData = movies
        DispatchQueue.main.async {
            self.dataSource.collectionView?.reloadData()
        }
    }
    
    internal func fetchImage(url: String?,completion: @escaping (Data)  -> ())  {
        networkController.fetchImage(url: url, completion: completion)
    }
    
    internal func layoutChanged(){
        view.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    internal func traitChanged(trait: UITraitCollection){
        dataSource?.traitChanged(traitCollection: trait)
    }
    
    internal func presetVC(data: Movie, image: UIImage) {
        delegate?.presentViewController(data: data, image: image)
    }
}

protocol DSDelegate {
    func fetchImage(url: String?,completion: @escaping (Data)  -> ())
    func presetVC(data: Movie, image: UIImage)
    var modelData: [Movie]? { get set }
}
