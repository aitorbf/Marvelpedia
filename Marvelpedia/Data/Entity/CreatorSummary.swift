//
//  CreatorSummary.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class CreatorSummary: Codable {
    
    // MARK: Public constants
    
    let resourceURI: String?
    let name: String?
    let role: String?
    
    // MARK: Initializers
    
    init() {
        resourceURI = nil
        name = nil
        role = nil
    }
}
