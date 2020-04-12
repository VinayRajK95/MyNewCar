//
//  CollectionviewDSandDelegate.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 12/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//
import UIKit
import Foundation

class CollectionviewDSandDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate var traitCollection: UITraitCollection?
    
    fileprivate var itemsPerRow = 2
    
    internal var delegate: DSDelegate!
    
    internal var collectionView: UICollectionView? {
        didSet{
            collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.modelData?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = delegate.modelData, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let url = data[indexPath.row].show.image?.original
        delegate.fetchImage(url: url, completion: cell.configure(imgData:))
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = delegate.modelData?[indexPath.row], let cell = (collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell), let image = cell.imageView.image else { return }
        delegate.presetVC(data: data, image: image)
    }
    
    fileprivate func getCellSize() -> CGSize {
        let pageWidth = Int(collectionView?.bounds.width ?? 0)
        getItemsPerRow()
        var cellWidth = pageWidth - (itemsPerRow-1)*Paddings.minInterItemSpacing
        cellWidth = cellWidth/itemsPerRow
        let cellHeight = cellWidth*4/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    fileprivate func getItemsPerRow() {
        switch traitCollection?.horizontalSizeClass {
        case .compact:
            itemsPerRow = 2
        case .regular:
           itemsPerRow = 4
        default:
            break
        }
    }
    
    internal func traitChanged(traitCollection: UITraitCollection) {
        switch traitCollection.horizontalSizeClass {
        case .compact:
             itemsPerRow = 2
        case .regular:
            itemsPerRow = 4
        default:
            itemsPerRow = 2
            break
        }
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}
