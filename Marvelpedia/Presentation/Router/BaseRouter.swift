//
//  BaseRouter.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class BaseRouter {
    
    // MARK: Public variables
    
    var navigationController: UINavigationController?
    
    // MARK: Public methods
    
    func goTo(_ viewController: UIViewController) {
        if let navigationController = navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func goToPreviousScreen() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
