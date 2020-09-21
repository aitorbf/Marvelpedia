//
//  TextObject.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import Foundation

class TextObject: Codable {
    
    // MARK: Public constants
    
    let type: String?
    let language: String?
    let text: String?
    
    // MARK: Initializers
    
    init() {
        type = nil
        language = nil
        text = nil
    }
}
