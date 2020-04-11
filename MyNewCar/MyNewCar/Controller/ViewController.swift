//
//  ViewController.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let collectionView: UICollectionView = {
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

    fileprivate let viewModel = ViewModel()
    
    fileprivate var boundsChanged: CGRect!
    
    fileprivate var itemsPerRow = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.delegate = self
        viewModel.fetchData()
        
        setupCollectionView()
        registerCells()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = UIColor.systemBackground
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.bounds != boundsChanged {
            boundsChanged = view.bounds
            collectionView.collectionViewLayout.invalidateLayout()
            view.layoutIfNeeded()
        }
    }
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionViewContainer)
        collectionViewContainer.addSubview(collectionView)
        var constraints = [NSLayoutConstraint]()
        let padding = getPaddings()
        
        constraints += [collectionViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(padding)),collectionViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:CGFloat(-padding)),collectionViewContainer.leadingAnchor.constraint(equalTo:view.readableContentGuide.leadingAnchor),collectionViewContainer.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor)];
        
        constraints += [collectionView.topAnchor.constraint(equalTo: collectionViewContainer.topAnchor),collectionView.bottomAnchor.constraint(equalTo: collectionViewContainer.safeAreaLayoutGuide.bottomAnchor),collectionView.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor, constant: CGFloat(padding)),collectionView.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor, constant: CGFloat(-padding))];
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func registerCells() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewModel.modelData else {
            return 0
        }
        return data.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = viewModel.modelData, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let url = data[indexPath.row].show.image?.original
        viewModel.fetchImage(url: url, completion: cell.configure(imgData:))
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize();
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.modelData![indexPath.row]
        guard let cell = (collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell), let image = cell.imageView.image else { return }
        let viewController = DetailsViewController()
        viewController.loadViewIfNeeded()
        viewController.data = data
        viewController.image = image
        self.present(viewController, animated: true, completion: nil)
    }
    
    fileprivate func getCellSize() -> CGSize {
        let pageWidth = Int(collectionView.bounds.width)
        getItemsPerRow()
        var cellWidth = pageWidth - (itemsPerRow-1)*Paddings.minInterItemSpacing
        cellWidth = cellWidth/itemsPerRow
        let cellHeight = cellWidth*4/3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    fileprivate func getItemsPerRow() {
        switch traitCollection.horizontalSizeClass {
        case .compact:
            itemsPerRow = 2
        case .regular:
           itemsPerRow = 4
        default:
            break
        }
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
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass {
            switch traitCollection.horizontalSizeClass {
            case .compact:
                 itemsPerRow = 2
            case .regular:
                itemsPerRow = 4
            default:
                itemsPerRow = 2
                break
            }
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}


extension ViewController : Operations {
    
    func errorOccured() {
        let alert = UIAlertController(title: "Oops an error occurered", message: "Please try again later", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func UpdateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
}

protocol Operations: NSObject {
    func errorOccured()
    func UpdateUI()
    
}

protocol UpdateCells {
    func configure(imgData: Data)
}

extension NSLayoutConstraint {
    
    public static func createConstraint(format: String, subViewDict: [String: AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: subViewDict)
    }
    
}
