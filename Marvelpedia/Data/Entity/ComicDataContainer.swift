//
//  ComicDataContainer.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicDataContainer: Codable {
    
    // MARK: Public constants
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [ComicEntity]?
    
    // MARK: Initializers
    
    init() {
        offset = nil
        limit = nil
        total = nil
        count = nil
        results = nil
    }
}
