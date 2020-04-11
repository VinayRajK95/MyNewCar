//
//  DetailsView.swift
//  MyNewCar
//
//  Created by Vinay Raj K on 11/04/20.
//  Copyright © 2020 Vinay Raj K. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
    let titleLabel : UILabel = {
        let innerLabel = UILabel()
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let imageView : UIImageView = {
        let innerImageView = UIImageView(frame: CGRect.zero)
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        innerImageView.contentMode = .scaleAspectFit
        innerImageView.layer.cornerRadius = 10
        innerImageView.layer.masksToBounds = true
        innerImageView.translatesAutoresizingMaskIntoConstraints = false
        return innerImageView
    }()
    
    let rating : UILabel = {
        let innerLabel = UILabel()
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let runTime : UILabel = {
        let innerLabel = UILabel()
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let releasedOn : UILabel = {
        let innerLabel = UILabel()
        innerLabel.translatesAutoresizingMaskIntoConstraints = false
        innerLabel.textColor = UIColor.black
        innerLabel.textAlignment = .left
        return innerLabel
    }()
    
    let summary : UITextView = {
        let innerTextView = UITextView()
        innerTextView.translatesAutoresizingMaskIntoConstraints = false
        innerTextView.textColor = UIColor.black
        innerTextView.textAlignment = .left
        return innerTextView
    }()
    
    let containerView: UIView = {
        let innerView = UIView(frame: CGRect.zero)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.backgroundColor = UIColor.clear
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOffset = CGSize.zero
        innerView.layer.shadowOpacity = 0.5
        return innerView
    }()
    
    fileprivate var subViewDict: [String: AnyObject]!
    
    var constraintsForView = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(rating)
        containerView.addSubview(runTime)
        containerView.addSubview(releasedOn)
        containerView.addSubview(summary)
        
        subViewDict = ["imageView":imageView,"titleLabel":titleLabel,"rating":rating,"runTime":runTime,"releasedOn":releasedOn,"summary":summary]
        
        
        constraintsForView += NSLayoutConstraint.createConstraint(format:"V:|[containerView]|" ,subViewDict: ["containerView":containerView]);
        constraintsForView += NSLayoutConstraint.createConstraint(format:"H:|-[titleLabel]-(>=0)-|" ,subViewDict: subViewDict);
        constraintsForView += NSLayoutConstraint.createConstraint(format:"H:|-[releasedOn]-[rating]-[runTime]-(>=0)-|" ,subViewDict: subViewDict);
        constraintsForView += NSLayoutConstraint.createConstraint(format:"H:|-[summary]-|" ,subViewDict: subViewDict);
        
        constraintsForView += NSLayoutConstraint.createConstraint(format:"V:|[imageView]-[releasedOn]-[titleLabel]-[summary]-|" ,subViewDict: subViewDict);
        

        
        constraintsForView += [containerView.leadingAnchor.constraint(equalTo: self.readableContentGuide.leadingAnchor),containerView.trailingAnchor.constraint(equalTo: self.readableContentGuide.trailingAnchor),imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.8),imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),rating.topAnchor.constraint(equalTo: releasedOn.topAnchor),runTime.topAnchor.constraint(equalTo: releasedOn.topAnchor)]

        NSLayoutConstraint.activate(constraintsForView)
    }

}
