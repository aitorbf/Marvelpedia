//
//  ComicDate.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicDate: Codable {
    
    // MARK: Public constants
    
    let type: String?
    let date: Date?
    
    // MARK: Initializers
    
    init() {
        type = nil
        date = nil
    }
}
