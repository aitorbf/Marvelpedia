//
//  MarvelOperationQueueDelegate.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

protocol MarvelOperationQueueDelegate {
    
    func operationQueueStarted()
    
    func operationQueueFinished()
    
    func operationNeedsReset(name: String)
}
