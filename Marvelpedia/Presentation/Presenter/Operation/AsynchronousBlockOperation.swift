//
//  AsynchronousBlockOperation.swift
//  Marvelpedia
//
//  Created by Aitor on 18/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

final class AsynchronousBlockOperation : AsynchronousOperation {
    
    private var block : (AsynchronousBlockOperation) -> ()
    
    init(block : @escaping (AsynchronousBlockOperation) -> ()) {
        self.block = block
    }
    
    override func main() {
        // If we were executing already
        let wasExecuting = (state == .executing)
        
        // Call our main to ensure we are not cancelled
        super.main()
        
        if !wasExecuting
        {
            block(self)
        }
    }
}
