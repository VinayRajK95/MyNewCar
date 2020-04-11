//
//  DetailsViewController.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailsView = DetailsView()
    
    var data: Movie? = nil
    
    var image: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailsView)
        view.backgroundColor = .systemBackground
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.createConstraint(format:"H:|[detailsView]|" ,subViewDict: ["detailsView":detailsView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.createConstraint(format:"V:|[detailsView]|" ,subViewDict: ["detailsView":detailsView]));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }

    func updateUI() {
        detailsView.imageView.image = image
        detailsView.rating.text = "\(data?.show.rating?.average ?? 0)"
        detailsView.releasedOn.text = data?.show.premiered
        detailsView.runTime.text = "\(data?.show.runtime ?? 0)"
        detailsView.summary.text = data?.show.summary
    }

}
