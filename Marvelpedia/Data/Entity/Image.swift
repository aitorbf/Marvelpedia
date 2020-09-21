//
//  Image.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class Image: Codable {
    
    // MARK: Enums
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    // MARK: Public constants
    
    let path: String?
    let imageExtension: String?
    
    // MARK: Initializers
    
    init() {
        path = nil
        imageExtension = nil
    }
}
