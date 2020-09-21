//
//  MarvelOperationQueue.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class MarvelOperationQueue: OperationQueue {
    
    // MARK: Private variables
    
    private var observation: NSKeyValueObservation?
    private var customOperations: [Operation]?
    
    // MARK: Public variables
    
    var delegate: MarvelOperationQueueDelegate?
    
    // MARK: Overriden methods
    
    override init() {
        super.init()
        qualityOfService = .background
        addObserverWhenFinished()
    }
    
    // MARK: Deinitializers
    
    deinit {
        self.observation = nil
    }
    
    // MARK: Public methods
    
    func addOperations(operations: [Operation]) {
        let result = checkValidOperations(operations: operations)
        if result.validOperations {
            if let operations = result.operations {
                customOperations = operations
            }
        } else {
            customOperations = nil
            if let delegate = delegate { delegate.operationQueueFinished() }
        }
    }
    
    func start() {
        if let operations = customOperations {
            if let delegate = delegate { delegate.operationQueueStarted() }
            addOperations(operations, waitUntilFinished: false)
        } else {
            if let delegate = delegate { delegate.operationQueueFinished() }
        }
    }
    
    func cancelOperations() {
        cancelAllOperations()
    }
    
    // MARK: Private methods
    
    private func checkValidOperations(operations: [Operation]) ->
        (operations: [Operation]?, validOperations: Bool) {
        var validOperations = operations
        for operation in operations {
            if operation.isFinished {
                if let customIndex = validOperations.firstIndex(of: operation) {
                    validOperations.remove(at: customIndex)
                }
            }
        }
        if !validOperations.isEmpty {
            return (operations: validOperations, validOperations: true)
        }
        return (operations: nil, validOperations: false)
    }
    
    private func addObserverWhenFinished() {
        observation = self.observe(\.operationCount, options: [.new]) { [unowned self] (queue, change) in
            if change.newValue! == 0 {
                if let delegate = self.delegate {
                    delegate.operationQueueFinished()
                }
                self.reset()
            }
        }
    }
    
    private func reset() {
        guard let operations = customOperations else { return }
        guard let delegate = delegate else { return }
        
        for operation in operations {
            if operation.isFinished {
                if let operationName = operation.name {
                    delegate.operationNeedsReset(name: operationName)
                }
            }
        }
    }
}
