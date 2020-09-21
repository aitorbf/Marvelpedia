//
//  Url.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class Url: Codable {
    
    // MARK: Public constants
    
    let type: String?
    let url: String?
    
    // MARK: Initializers
    
    init() {
        type = nil
        url = nil
    }
}
