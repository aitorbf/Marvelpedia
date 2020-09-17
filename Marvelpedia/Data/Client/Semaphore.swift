//
//  Semaphore.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class Semaphore {
    
    // MARK: Private constants
    
    private let maxNumberOfConcurrentThreads = 1
    
    // MARK: Private variables
    
    private var semaphore: DispatchSemaphore? = nil
    
    // MARK: Initializers
    
    init() {
        semaphore = DispatchSemaphore(value: maxNumberOfConcurrentThreads)
    }
    
    // MARK: Public methods
    
    func wait() {
        guard let semaphore = semaphore else { return }
        
        semaphore.wait()
    }
    
    func `continue`() {
        guard let semaphore = semaphore else { return }
        
        semaphore.signal()
    }
}
