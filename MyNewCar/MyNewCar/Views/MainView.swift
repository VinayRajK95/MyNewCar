//
//  MainView.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 12/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class MainView: UIView {

    internal let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        let innerCollectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: layout)
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        innerCollectionView.backgroundColor = UIColor.clear
        return innerCollectionView
    }()
    
    fileprivate let collectionViewContainer: UIView = {
        let innerView = UIView(frame: CGRect.zero)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.clear
        return innerView
    }()
    
    fileprivate var itemsPerRow = 2;
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
    }

    required init?(coder: NSCoder) {
       super.init(coder: coder)
       commonInit()
    }

    fileprivate func commonInit() {
       setupCollectionView()
    }

    fileprivate func setupCollectionView() {
        self.addSubview(collectionViewContainer)
        collectionViewContainer.addSubview(collectionView)
        var constraints = [NSLayoutConstraint]()
        let padding = getPaddings()

        constraints += [collectionViewContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),collectionViewContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant:CGFloat(-padding)),collectionViewContainer.leadingAnchor.constraint(equalTo:self.readableContentGuide.leadingAnchor),collectionViewContainer.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor)];

        constraints += [collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.safeAreaLayoutGuide.bottomAnchor),collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor, constant: CGFloat(padding)),collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: CGFloat(-padding))];

        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func getPaddings() -> Int {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            return Paddings.compactPadding
        case .regular:
            return Paddings.regularPadding
        default:
            return 12
        }
    }
    

}
