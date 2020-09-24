//
//  BasePresenter.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class BasePresenter: MarvelOperationQueueDelegate {
    
    // MARK: Public variables
    
    var queue: MarvelOperationQueue? = nil
    
    // MARK: Initializers
    
    init() {
        if queue == nil { queue = MarvelOperationQueue() }
        if let queue = queue { queue.delegate = self }
    }
    
    // MARK: OperationQueueDelegate protocol conformance

    func operationQueueStarted() {}
    
    func operationQueueFinished() {}
    
    func operationNeedsReset(name: String) {}
}
