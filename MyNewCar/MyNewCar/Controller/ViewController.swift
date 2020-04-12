//
//  ViewController.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let viewModel = ViewModel()
    
    fileprivate var boundsChanged: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = viewModel.view
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.delegate = self
        viewModel.fetchData()
        viewModel.dataSource.delegate = viewModel

        view.backgroundColor = UIColor.systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.bounds != boundsChanged {
            boundsChanged = view.bounds
            viewModel.layoutChanged()
            view.layoutIfNeeded()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass {
            viewModel.traitChanged(trait: traitCollection)
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
    
    func presentViewController(data: Movie,image: UIImage) {
        let viewController = DetailsViewController()
        viewController.loadViewIfNeeded()
        viewController.data = data
        viewController.image = image
        self.present(viewController, animated: true, completion: nil)
    }
    
}

protocol Operations: NSObject {
    func errorOccured()
    func presentViewController(data: Movie,image: UIImage)
    
}

protocol UpdateCells {
    func configure(imgData: Data)
}

extension NSLayoutConstraint {
    
    public static func createConstraint(format: String, subViewDict: [String: AnyObject]) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: subViewDict)
    }
    
}
