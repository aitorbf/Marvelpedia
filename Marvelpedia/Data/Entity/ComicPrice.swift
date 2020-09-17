//
//  ComicPrice.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class ComicPrice: Codable {
    
    // MARK: Public constants
    
    let type: String?
    let price: Float?
    
    // MARK: Initializers
    
    init() {
        type = nil
        price = nil
    }
}
