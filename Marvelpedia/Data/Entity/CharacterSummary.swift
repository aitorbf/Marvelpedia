//
//  CharacterSummary.swift
//  Marvelpedia
//
//  Created by Aitor on 17/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class CharacterSummary: Codable {
    
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
