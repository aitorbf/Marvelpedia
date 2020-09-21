//
//  UIViewControllerExtension.swift
//  Marvelpedia
//
//  Created by Aitor on 20/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

var spinner: UIView?

extension UIViewController {
    
    func createLoadingSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = spinnerView.center
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func showSpinner() {
        spinner?.isHidden = false
    }
    
    func hideSpinner() {
        spinner?.isHidden = true
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
}
